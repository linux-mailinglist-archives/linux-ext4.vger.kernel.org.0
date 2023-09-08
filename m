Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A934C7986B0
	for <lists+linux-ext4@lfdr.de>; Fri,  8 Sep 2023 14:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232343AbjIHMCq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 8 Sep 2023 08:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238353AbjIHMCp (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 8 Sep 2023 08:02:45 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945B41BC5
        for <linux-ext4@vger.kernel.org>; Fri,  8 Sep 2023 05:02:40 -0700 (PDT)
Received: from kwepemm600013.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Rhvnq6pk9z1M90m;
        Fri,  8 Sep 2023 20:00:47 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 8 Sep 2023 20:02:37 +0800
Subject: Re: [PATCH] jbd2: Fix potential data lost in recovering journal raced
 with synchronizing fs bdev
To:     Jan Kara <jack@suse.cz>
CC:     <tytso@mit.edu>, <jack@suse.com>, <linux-ext4@vger.kernel.org>,
        <yi.zhang@huawei.com>
References: <20230908092808.2929317-1-chengzhihao1@huawei.com>
 <20230908111455.koi76sueeved5jpm@quack3>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <cb645a7c-bcd2-69f9-fa36-0dafbb0f7607@huawei.com>
Date:   Fri, 8 Sep 2023 20:02:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20230908111455.koi76sueeved5jpm@quack3>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

ÔÚ 2023/9/8 19:14, Jan Kara Ð´µÀ:
Hi Jan,
> On Fri 08-09-23 17:28:08, Zhihao Cheng wrote:
>> JBD2 makes sure journal data is fallen on fs device by sync_blockdev(),
>> however, other process could intercept the EIO information from bdev's
>> mapping, which leads journal recovering successful even EIO occurs during
>> data written back to fs device.
>>
>> We found this problem in our product, iscsi + multipath is chosen for block
>> device of ext4. Unstable network may trigger kpartx to rescan partitions in
>> device mapper layer. Detailed process is shown as following:
>>
>>    mount          kpartx          irq
>> jbd2_journal_recover
>>   do_one_pass
>>    memcpy(nbh->b_data, obh->b_data) // copy data to fs dev from journal
>>    mark_buffer_dirty // mark bh dirty
>>           vfs_read
>> 	  generic_file_read_iter // dio
>> 	   filemap_write_and_wait_range
>> 	    __filemap_fdatawrite_range
>> 	     do_writepages
>> 	      block_write_full_folio
>> 	       submit_bh_wbc
>> 	            >>  EIO occurs in disk  <<
>> 	                     end_buffer_async_write
>> 			      mark_buffer_write_io_error
>> 			       mapping_set_error
>> 			        set_bit(AS_EIO, &mapping->flags) // set!
>> 	    filemap_check_errors
>> 	     test_and_clear_bit(AS_EIO, &mapping->flags) // clear!
>>   err2 = sync_blockdev
>>    filemap_write_and_wait
>>     filemap_check_errors
>>      test_and_clear_bit(AS_EIO, &mapping->flags) // false
>>   err2 = 0
>>
>> Filesystem is mounted successfully even data from journal is failed written
>> into disk, and ext4/ocfs2 could become corrupted.
>>
>> Fix it by comparing the wb_err state in fs block device before recovering
>> and after recovering.
>>
>> Fetch a reproducer in [Link].
>>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217888
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> 
> Thanks for the patch! It makes sense but it is somewhat inconsistent with
> how we deal with other checks for metadata IO errors in ext4. We do those
> checks in ext4 through ext4_check_bdev_write_error(). So I wonder if in
> this case we shouldn't move the errseq_check_and_advance() in
> __ext4_fill_super() earlier (before journal setup) and then use it in
> ext4_load_and_init_journal() to detect errors during background metadata
> writeback. What do you think?
> 

Do you mean that modify like this?
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 38217422f938..3f6239f8cc4e 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4907,6 +4907,13 @@ static int ext4_load_and_init_journal(struct 
super_block *sb,
         if (err)
                 return err;

+       err = 
errseq_check_and_advance(&sb->s_bdev->bd_inode->i_mapping->wb_err,
+                                      &sbi->s_bdev_wb_err);
+       if (err) {
+               ext4_msg(sb, KERN_ERR, "Failed to sync fs block device");
+               goto out;
+       }
+
         if (ext4_has_feature_64bit(sb) &&
             !jbd2_journal_set_features(EXT4_SB(sb)->s_journal, 0, 0,
                                        JBD2_FEATURE_INCOMPAT_64BIT)) {
@@ -5365,6 +5372,13 @@ static int __ext4_fill_super(struct fs_context 
*fc, struct super_block *sb)
                         goto failed_mount3a;
         }

+       /*
+        * Save the original bdev mapping's wb_err value which could be
+        * used to detect the metadata async write error.
+        */
+       spin_lock_init(&sbi->s_bdev_wb_lock);
+       errseq_check_and_advance(&sb->s_bdev->bd_inode->i_mapping->wb_err,
+                                &sbi->s_bdev_wb_err);
         err = -EINVAL;
         /*
          * The first inode we look at is the journal inode.  Don't try
@@ -5571,13 +5585,6 @@ static int __ext4_fill_super(struct fs_context 
*fc, struct super_block *sb)
         }
  #endif  /* CONFIG_QUOTA */

-       /*
-        * Save the original bdev mapping's wb_err value which could be
-        * used to detect the metadata async write error.
-        */
-       spin_lock_init(&sbi->s_bdev_wb_lock);
-       errseq_check_and_advance(&sb->s_bdev->bd_inode->i_mapping->wb_err,
-                                &sbi->s_bdev_wb_err);
         EXT4_SB(sb)->s_mount_state |= EXT4_ORPHAN_FS;
         ext4_orphan_cleanup(sb, es);
         EXT4_SB(sb)->s_mount_state &= ~EXT4_ORPHAN_FS;

If so, there are two points:
1. ocfs2 also uses jbd2, we only fix ext4.
2. EIO from ext4_commit_super() in ext4_load_journal is ignored, now 
ext4 will fail mounting.

> 								Honza
> 
>> ---
>>   fs/jbd2/recovery.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
>> index c269a7d29a46..0fecaa6a3ac6 100644
>> --- a/fs/jbd2/recovery.c
>> +++ b/fs/jbd2/recovery.c
>> @@ -289,6 +289,8 @@ int jbd2_journal_recover(journal_t *journal)
>>   	journal_superblock_t *	sb;
>>   
>>   	struct recovery_info	info;
>> +	errseq_t		wb_err;
>> +	struct address_space	*mapping;
>>   
>>   	memset(&info, 0, sizeof(info));
>>   	sb = journal->j_superblock;
>> @@ -306,6 +308,8 @@ int jbd2_journal_recover(journal_t *journal)
>>   		return 0;
>>   	}
>>   
>> +	mapping = journal->j_fs_dev->bd_inode->i_mapping;
>> +	errseq_check_and_advance(&mapping->wb_err, &wb_err);
>>   	err = do_one_pass(journal, &info, PASS_SCAN);
>>   	if (!err)
>>   		err = do_one_pass(journal, &info, PASS_REVOKE);
>> @@ -327,6 +331,9 @@ int jbd2_journal_recover(journal_t *journal)
>>   
>>   	jbd2_journal_clear_revoke(journal);
>>   	err2 = sync_blockdev(journal->j_fs_dev);
>> +	if (!err)
>> +		err = err2;
>> +	err2 = errseq_check_and_advance(&mapping->wb_err, &wb_err);
>>   	if (!err)
>>   		err = err2;
>>   	/* Make sure all replayed data is on permanent storage */
>> -- 
>> 2.39.2
>>

