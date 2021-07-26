Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1E9A3D53A7
	for <lists+linux-ext4@lfdr.de>; Mon, 26 Jul 2021 09:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232038AbhGZGdI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 26 Jul 2021 02:33:08 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:7060 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbhGZGdH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 26 Jul 2021 02:33:07 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GY9ws6ZXNzYg5H;
        Mon, 26 Jul 2021 15:07:41 +0800 (CST)
Received: from dggema766-chm.china.huawei.com (10.1.198.208) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Mon, 26 Jul 2021 15:13:35 +0800
Received: from [10.174.177.210] (10.174.177.210) by
 dggema766-chm.china.huawei.com (10.1.198.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Mon, 26 Jul 2021 15:13:34 +0800
Subject: Re: [PATCH] ext4: flush s_error_work before journal destroy in
 ext4_fill_super
To:     Theodore Ts'o <tytso@mit.edu>
CC:     <jack@suse.cz>, <linux-ext4@vger.kernel.org>, <yukuai3@huawei.com>
References: <YPsUZX+PF5HASRkK@mit.edu>
From:   yangerkun <yangerkun@huawei.com>
Message-ID: <b83ee217-3dbb-62b8-237f-db8ca663fef5@huawei.com>
Date:   Mon, 26 Jul 2021 15:13:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <YPsUZX+PF5HASRkK@mit.edu>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.210]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggema766-chm.china.huawei.com (10.1.198.208)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



在 2021/7/24 3:11, Theodore Ts'o 写道:
> On Fri, Jul 23, 2021 at 09:11:08PM +0800, yangerkun wrote:
>>
>> For example, before wo goto failed_mount_wq, we may meet some error and will
>> goto ext4_handle_error which can call
>> schedule_work(&EXT4_SB(sb)->s_error_work). So the work may start concurrent
>> with ext4_fill_super goto failed_mount_wq. There does not have any lock to
>> protect the concurrent read and modifies for sbi->s_journal.
> 
> Yes, and I'm asking *how* is this actually happening in practice?
> I've been going through the code paths and I don't see any place where
> ext4_error*() would be called.  That's why I wanted to see your test
> case which was reproducing it.  (Not just where you added the msleep,
> but how the error was getting triggered in the first place.)

Hi Ted,


The problem only happened once early with parallel ltp testcase(but we
cannot reproduce it again with same case...). And dmesg with latter:


[32031.739678] EXT4-fs error (device loop66): ext4_fill_super:4672: comm 
chdir01: inode #2: comm chdir01: iget: illegal inode #
[32031.740193] EXT4-fs (loop66): get root inode failed
[32031.740484] EXT4-fs (loop66): mount failed
[32031.758811] EXT4-fs error (device loop66): ext4_map_blocks:595: inode 
#8: block 532: comm chdir01: lblock 1 mapped to illegal pblock 532 
(length 1)
[32031.759293] jbd2_journal_bmap: journal block not found at offset 1 on 
loop66-8
[32031.759805] ------------[ cut here ]------------
[32031.759807] kernel BUG at fs/jbd2/transaction.c:373!


ext4_fill_super
     ext4_load_journal
         EXT4_SB(sb)->s_journal = journal
     root = ext4_iget(sb, EXT4_ROOT_INO, EXT4_IGET_SPECIAL)
     // will failed and goto failed_mount4
         __ext4_iget
            __ext4_error
                ext4_handle_error
                   schedule_work(&EXT4_SB(sb)->s_error_work)


And this trigger the concurrent read and modifies for sbi->s_journal...

Thanks,
Kun.


> 
> 
> On Fri, Jul 23, 2021 at 09:25:12PM +0800, yangerkun wrote:
>>
>>> Can you share with me your test case?  Your patch will result in the
>>> shrinker potentially not getting released in some error paths (which
>>> will cause other kernel panics), and in any case, once the journal is
>>
>> The only logic we have changed is that we move the flush_work before we call
>> jbd2_journal_destory. I have not seen the problem you describe... Can you
>> help to explain more...
> 
> Sorry, I was mistaken.  I thought you were moving the
> ext4_es_unregister_shrinker() and flush_work() before the label for
> failed_mount_wq; that was a misreading of your patch.
> 
> The other way we could fix this might be something like this:
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index dfa09a277b56..d663d11fa0de 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -693,7 +693,7 @@ static void flush_stashed_error_work(struct work_struct *work)
>   {
>   	struct ext4_sb_info *sbi = container_of(work, struct ext4_sb_info,
>   						s_error_work);
> -	journal_t *journal = sbi->s_journal;
> +	journal_t *journal = READ_ONCE(sbi->s_journal);
>   	handle_t *handle;
>   
>   	/*
> @@ -1184,9 +1184,11 @@ static void ext4_put_super(struct super_block *sb)
>   	ext4_unregister_sysfs(sb);
>   
>   	if (sbi->s_journal) {
> -		aborted = is_journal_aborted(sbi->s_journal);
> -		err = jbd2_journal_destroy(sbi->s_journal);
> -		sbi->s_journal = NULL;
> +		journal_t *journal = sbi->s_journal;
> +
> +		WRITE_ONCE(sbi->s_journal, NULL);
> +		aborted = is_journal_aborted(journal);
> +		err = jbd2_journal_destroy(journal);
>   		if ((err < 0) && !aborted) {
>   			ext4_abort(sb, -err, "Couldn't clean up the journal");
>   		}
> @@ -5175,8 +5177,10 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
>   	sbi->s_ea_block_cache = NULL;
>   
>   	if (sbi->s_journal) {
> -		jbd2_journal_destroy(sbi->s_journal);
> -		sbi->s_journal = NULL;
> +		journal_t *journal = sbi->s_journal;
> +
> +		WRITE_ONCE(sbi->s_journal, NULL);
> +		jbd2_journal_destroy(journal);
>   	}
>   failed_mount3a:
>   	ext4_es_unregister_shrinker(sbi);
> @@ -5487,7 +5491,7 @@ static int ext4_load_journal(struct super_block *sb,
>   	EXT4_SB(sb)->s_journal = journal;
>   	err = ext4_clear_journal_err(sb, es);
>   	if (err) {
> -		EXT4_SB(sb)->s_journal = NULL;
> +		WRITE_ONCE(EXT4_SB(sb)->s_journal, NULL);
>   		jbd2_journal_destroy(journal);
>   		return err;
>   	}
> 
> ... and here's another possible fix:
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index dfa09a277b56..e9e122e52ce8 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -704,7 +704,8 @@ static void flush_stashed_error_work(struct work_struct *work)
>   	 * We use directly jbd2 functions here to avoid recursing back into
>   	 * ext4 error handling code during handling of previous errors.
>   	 */
> -	if (!sb_rdonly(sbi->s_sb) && journal) {
> +	if (!sb_rdonly(sbi->s_sb) && journal &&
> +	    !(journal->j_flags & JBD2_UNMOUNT)) {
>   		struct buffer_head *sbh = sbi->s_sbh;
>   		handle = jbd2_journal_start(journal, 1);
>   		if (IS_ERR(handle))
> 
> 
> 
> But I would be interested in understanding how we could be triggering
> this problem in the first place before deciding what's the best fix.
> 
> Cheers,
> 
> 					- Ted
> .
> 
