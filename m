Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8944FE3BB
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Apr 2022 16:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351179AbiDLO2O (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 12 Apr 2022 10:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350558AbiDLO2N (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 12 Apr 2022 10:28:13 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D9A56C1A
        for <linux-ext4@vger.kernel.org>; Tue, 12 Apr 2022 07:25:53 -0700 (PDT)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Kd7FV71ckzBs7x;
        Tue, 12 Apr 2022 22:21:34 +0800 (CST)
Received: from [10.174.178.134] (10.174.178.134) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 12 Apr 2022 22:25:51 +0800
Subject: Re: [RFC PATCH v2] ext4: convert symlink external data block mapping
 to bdev
To:     Jan Kara <jack@suse.cz>
CC:     <linux-ext4@vger.kernel.org>, <tytso@mit.edu>,
        <adilger.kernel@dilger.ca>, <yukuai3@huawei.com>,
        <yebin10@huawei.com>
References: <20220412083941.2242143-1-yi.zhang@huawei.com>
 <20220412102716.wmsfzbznkmdf3jqi@quack3.lan>
From:   Zhang Yi <yi.zhang@huawei.com>
Message-ID: <cd0663ef-3387-695c-91f6-64649e435960@huawei.com>
Date:   Tue, 12 Apr 2022 22:25:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20220412102716.wmsfzbznkmdf3jqi@quack3.lan>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.134]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi, Jan.
Thanks a lot for the review.

On 2022/4/12 18:27, Jan Kara wrote:
> 
> Hello,
> 
> On Tue 12-04-22 16:39:41, Zhang Yi wrote:
>> Symlink's external data block is one kind of metadata block, and now
>> that almost all ext4 metadata block's page cache (e.g. directory blocks,
>> quota blocks...) belongs to bdev backing inode except the symlink. It
>> is essentially worked in data=journal mode like other regular file's
>> data block because probably in order to make it simple for generic VFS
>> code handling symlinks or some other historical reasons, but the logic
>> of creating external data block in ext4_symlink() is complicated. and it
>> also make things confused if user do not want to let the filesystem
>> worked in data=journal mode. This patch convert the final exceptional
>> case and make things clean, move the mapping of the symlink's external
>> data block to bdev like any other metadata block does.
>>
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> 
> I had a closer look into some of the details. See my comments below:
> 
>> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
>> index e37da8d5cd0c..fa8002aae829 100644
>> --- a/fs/ext4/namei.c
>> +++ b/fs/ext4/namei.c
>> @@ -3249,6 +3249,32 @@ static int ext4_unlink(struct inode *dir, struct dentry *dentry)
>>  	return retval;
>>  }
>>  
>> +static int ext4_init_symlink_block(handle_t *handle, struct inode *inode,
>> +				   struct fscrypt_str *disk_link)
>> +{
>> +	struct buffer_head *bh;
>> +	char *kaddr;
>> +	int err = 0;
>> +
>> +	bh = ext4_bread(handle, inode, 0, EXT4_GET_BLOCKS_CREATE);
>> +	if (IS_ERR(bh))
>> +		return PTR_ERR(bh);
> 
> This is now more likely to fail in close-to-ENOSPC conditions because we
> don't do the force transaction commit to free blocks & retry dance here
> (like we do in ext4_write_begin()). I guess we'd need to implement retry
> in the ext4_symlink() to fix this.

Yes, I will add the ENOSPC retry logic in next iteration.

> 
>> +	BUFFER_TRACE(bh, "get_write_access");
>> +	err = ext4_journal_get_write_access(handle, inode->i_sb, bh, EXT4_JTR_NONE);
>> +	if (err)
>> +		goto out;
>> +
>> +	kaddr = (char *)bh->b_data;
>> +	memcpy(kaddr, disk_link->name, disk_link->len);
>> +	inode->i_size = disk_link->len - 1;
>> +	EXT4_I(inode)->i_disksize = inode->i_size;
>> +	err = ext4_handle_dirty_metadata(handle, inode, bh);
>> +out:
>> +	brelse(bh);
>> +	return err;
>> +}
>> +
>>  static int ext4_symlink(struct user_namespace *mnt_userns, struct inode *dir,
>>  			struct dentry *dentry, const char *symname)
>>  {
[..]
>> @@ -3305,73 +3319,52 @@ static int ext4_symlink(struct user_namespace *mnt_userns, struct inode *dir,
>>  		if (err)
>>  			goto err_drop_inode;
>>  		inode->i_op = &ext4_encrypted_symlink_inode_operations;
>> +	} else {
>> +		if ((disk_link.len > EXT4_N_BLOCKS * 4)) {
>> +			inode->i_op = &ext4_symlink_inode_operations;
>> +		} else {
>> +			inode->i_op = &ext4_fast_symlink_inode_operations;
>> +			inode->i_link = (char *)&EXT4_I(inode)->i_data;
>> +		}
>>  	}
>>  
>>  	if ((disk_link.len > EXT4_N_BLOCKS * 4)) {
>> -		if (!IS_ENCRYPTED(inode))
>> -			inode->i_op = &ext4_symlink_inode_operations;
>> -		inode_nohighmem(inode);
>> -		ext4_set_aops(inode);
>> -		/*
>> -		 * We cannot call page_symlink() with transaction started
>> -		 * because it calls into ext4_write_begin() which can wait
>> -		 * for transaction commit if we are running out of space
>> -		 * and thus we deadlock. So we have to stop transaction now
>> -		 * and restart it when symlink contents is written.
>> -		 *
>> -		 * To keep fs consistent in case of crash, we have to put inode
>> -		 * to orphan list in the mean time.
>> -		 */
>> -		drop_nlink(inode);
>> -		err = ext4_orphan_add(handle, inode);
>> -		if (handle)
>> -			ext4_journal_stop(handle);
>> -		handle = NULL;
>> +		/* alloc symlink block and fill it */
>> +		err = ext4_init_symlink_block(handle, inode, &disk_link);
>>  		if (err)
>>  			goto err_drop_inode;
>> -		err = __page_symlink(inode, disk_link.name, disk_link.len, 1);
>> -		if (err)
>> -			goto err_drop_inode;
>> -		/*
>> -		 * Now inode is being linked into dir (EXT4_DATA_TRANS_BLOCKS
>> -		 * + EXT4_INDEX_EXTRA_TRANS_BLOCKS), inode is also modified
>> -		 */
>> -		handle = ext4_journal_start(dir, EXT4_HT_DIR,
>> -				EXT4_DATA_TRANS_BLOCKS(dir->i_sb) +
>> -				EXT4_INDEX_EXTRA_TRANS_BLOCKS + 1);
>> -		if (IS_ERR(handle)) {
>> -			err = PTR_ERR(handle);
>> -			handle = NULL;
>> -			goto err_drop_inode;
>> -		}
>> -		set_nlink(inode, 1);
>> -		err = ext4_orphan_del(handle, inode);
>> +		err = ext4_mark_inode_dirty(handle, inode);
>> +		if (!err)
>> +			err = ext4_add_entry(handle, dentry, inode);
>>  		if (err)
>>  			goto err_drop_inode;
>> +
>> +		d_instantiate_new(dentry, inode);
>> +		if (IS_DIRSYNC(dir))
>> +			ext4_handle_sync(handle);
>> +		if (handle)
>> +			ext4_journal_stop(handle);
> 
> Why don't you use ext4_add_nondir() here like in the fastsymlink case? It
> would allow sharing more code between the two code paths...
> 

Hum, Yes. I was thinking about whether we need to explicit call
ext4_mark_inode_dirty() before ext4_add_entry(). We should mark the inode
dirty to attach the new created block with the raw inode if we failed to
add dir entry, otherwise it may lead to block leak if crash before the
final iput(). But think it again, IIUC, it looks unnecessary because
ext4_orphan_add() can guarantee that because it will always dirty the new
created inode(!NEXT_ORPHAN(inode) is ture). So I will switch to use
ext4_add_nondir() and to crash test.

>>  	} else {
>>  		/* clear the extent format for fast symlink */
>>  		ext4_clear_inode_flag(inode, EXT4_INODE_EXTENTS);
>> -		if (!IS_ENCRYPTED(inode)) {
>> -			inode->i_op = &ext4_fast_symlink_inode_operations;
>> -			inode->i_link = (char *)&EXT4_I(inode)->i_data;
>> -		}
>>  		memcpy((char *)&EXT4_I(inode)->i_data, disk_link.name,
>>  		       disk_link.len);
>>  		inode->i_size = disk_link.len - 1;
>> +		EXT4_I(inode)->i_disksize = inode->i_size;
>> +		err = ext4_add_nondir(handle, dentry, &inode);
>> +		if (handle)
>> +			ext4_journal_stop(handle);
>> +		if (inode)
>> +			iput(inode);
>>  	}
>> -	EXT4_I(inode)->i_disksize = inode->i_size;
>> -	err = ext4_add_nondir(handle, dentry, &inode);
>> -	if (handle)
>> -		ext4_journal_stop(handle);
>> -	if (inode)
>> -		iput(inode);
>>  	goto out_free_encrypted_link;
>>  
>>  err_drop_inode:
>> -	if (handle)
>> -		ext4_journal_stop(handle);
>>  	clear_nlink(inode);
>> +	ext4_orphan_add(handle, inode);
>>  	unlock_new_inode(inode);
>> +	if (handle)
>> +		ext4_journal_stop(handle);
>>  	iput(inode);
>>  out_free_encrypted_link:
>>  	if (disk_link.name != (unsigned char *)symname)
> 
> ...
> 
>> @@ -62,6 +65,31 @@ static int ext4_encrypted_symlink_getattr(struct user_namespace *mnt_userns,
>>  	return fscrypt_symlink_getattr(path, stat);
>>  }
>>  
>> +static void ext4_free_link(void *bh)
>> +{
>> +	brelse(bh);
>> +}
>> +
>> +static const char *ext4_get_link(struct dentry *dentry, struct inode *inode,
>> +				 struct delayed_call *callback)
>> +{
>> +	struct buffer_head *bh;
>> +
>> +	if (!dentry)
>> +		return ERR_PTR(-ECHILD);
> 
> So this essentially means you have disabled RCU walking for symlinks. I
> think that needs to be fixed (i.e., in !dentry case you need to check whether
> we have the buffer in the cache and provide it if yes).
> 

Yes.

>> +
>> +	bh = ext4_bread(NULL, inode, 0, 0);
>> +	if (IS_ERR(bh))
>> +		return ERR_CAST(bh);
>> +	if (!bh) {
>> +		EXT4_ERROR_INODE(inode, "bad symlink.");
>> +		return ERR_PTR(-EFSCORRUPTED);
>> +	}
>> +
> 
> page_get_link() has here the nd_terminate_link() call so the link is
> properly nul-terminated. I don't see anything assuring that in your code
> (even for cases where fs gets corrupted or so).
> 

In my ext4_init_symlink_block() have below hunk,

>> +	memcpy(kaddr, disk_link->name, disk_link->len);
>> +	inode->i_size = disk_link->len - 1;

The memcpy() have already copy the nul-terminated becase disk_link->len
include it, so it's fine if the symlink is okay. But yes, I missed the
corruption case, will fix it by call nd_terminate_link().

Thanks,
Yi.
