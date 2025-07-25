# Announcement Backend Setup & Testing Guide

## Current Status

✅ **Fixed**: Removed static sample data fallback  
✅ **Enhanced**: Added comprehensive error logging  
✅ **Improved**: More robust JSON parsing in the model

Now the app will fetch **real data from your Supabase backend**.

## Steps to Set Up Backend Data

### 1. Verify Supabase Connection

Make sure your Supabase configuration is working by checking other features that use the database.

### 2. Create Announcements Table

Run the provided SQL script (`SUPABASE_ANNOUNCEMENTS_SETUP.sql`) in your Supabase SQL editor:

```sql
-- This will create the table and insert sample announcements
-- Copy and paste the content from SUPABASE_ANNOUNCEMENTS_SETUP.sql
```

### 3. Check Supabase Policies

Make sure your Row Level Security (RLS) policies allow reading announcements:

```sql
-- Check if RLS is enabled
SELECT * FROM pg_tables WHERE tablename = 'announcements';

-- If you need to create a policy for reading announcements
CREATE POLICY "Allow reading published announcements" ON announcements
FOR SELECT TO authenticated
USING (is_published = true);

-- Or for testing, you can temporarily disable RLS
ALTER TABLE announcements DISABLE ROW LEVEL SECURITY;
```

## Debugging Steps

### 1. Check Debug Output

When you run the app and navigate to announcements, check the debug console for output like:

```
🔍 Fetching announcements from Supabase...
📡 Supabase response: [...]
📝 Found X announcements
✅ Successfully parsed X announcements
```

### 2. Common Issues & Solutions

#### Issue: "Failed to fetch announcements"

**Check:**

- Supabase connection URL and API key
- Internet connection
- Supabase project status

#### Issue: "Type 'List<Dynamic>' is not a subtype"

**Solution:** Already fixed with improved type casting

#### Issue: Empty list returned

**Check:**

- Data exists in the table: `SELECT * FROM announcements;`
- `is_published` column is set to `true`
- RLS policies are not blocking access

#### Issue: DateTime parsing errors

**Solution:** Already added safe parsing with fallbacks

## Testing Options

### Option 1: Use Real Database (Recommended)

1. Run the SQL script to create sample data
2. Test the app - should show real announcements

### Option 2: Test Empty State

1. Don't add any data to the database
2. App should show "There is no announcements" message

### Option 3: Test Error Handling

1. Temporarily change the table name in the service to something invalid
2. App should show error message with retry button

## Verification Checklist

- [ ] Supabase project is active and accessible
- [ ] `announcements` table exists with correct schema
- [ ] Sample data is inserted and `is_published = true`
- [ ] RLS policies allow reading (or RLS is disabled for testing)
- [ ] App shows debug output in console
- [ ] App displays real announcements or appropriate empty/error state

## Remove Debug Logging (Production)

Once everything is working, remove the `print` statements from:

- `lib/data/service/announcement/announcement_service.dart`
- `lib/data/models/announcement/annoucement_model.dart`

## Next Steps

After backend is working:

1. Test announcement read/unread functionality
2. Test the notification badge updates
3. Implement real-time updates (optional)
4. Add push notifications (optional)
