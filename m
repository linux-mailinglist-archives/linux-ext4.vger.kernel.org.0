Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE07E63318E
	for <lists+linux-ext4@lfdr.de>; Tue, 22 Nov 2022 01:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiKVArg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 21 Nov 2022 19:47:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbiKVArd (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 21 Nov 2022 19:47:33 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2322B31
        for <linux-ext4@vger.kernel.org>; Mon, 21 Nov 2022 16:47:30 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id k2so7976967qvo.1
        for <linux-ext4@vger.kernel.org>; Mon, 21 Nov 2022 16:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MF3kbAoqxsSpeBvRSJAkspZPGxoomAPUfzxCCqK4Bzk=;
        b=jofvdN7CldLN94CtUA/T4g6p78qUT7hIlzI0jCOkjKSiC0W4fIvBRPdujhavt6hu3Z
         DUmCYpX2BOrxvaGJS3/fxYsbe1NZ5wukKi6emzHFz4+NkLk2cUqWwh5gPjQRgQahNqiH
         eFT52RwnFd2gfKsEfpZLx94A1FLK4UOwbI56I7iL5mpLsn7OlkF90GnfduggT5LCSjoP
         LdlwIZbdI+U8y6DmNBmyaqt6KKHtJryAEzYjLKexqKwlDx38TpUCy8C7r2+kUpykCe2f
         To9NZ+ANG3DKL0dJhkVeNRBAd2MDdJE0WuaFaaiANnm6s3uEDatCMnkvyQUlBEObbfl8
         Lf6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MF3kbAoqxsSpeBvRSJAkspZPGxoomAPUfzxCCqK4Bzk=;
        b=7hBRNzRkJDkPS7JBA5ra0ncLIEZ9z0s7WWuvjI98ROha0QGN7j/cSsZtcXYusFAHWf
         SWIngIY5lP07/Yig4UUyYpkc4bcG5YV2ZYoNBteTCfR/W7g0JEyqKryTZtw/YdxhDpE/
         NSqszpJ++Ve04C6uYeAxIszWoO2OOnaTPVrAKeGs7o0blQdQcaPe29HNNdZKz8V3t8tf
         7UViT4WaJus+cTilO8+idki5pG2gEpcjZuZNz0ujSw6rjWW2e52MRlpzT3RMwKoEv8ir
         lALeC/O/ovMiA0sOdWzGRIVT5hcIL0fVXJ7Tt0x31G9HMi9fUWbj+AYpUps2XBHREeOq
         fppw==
X-Gm-Message-State: ANoB5pnmIJDYslEisRxkmzbpD2Zxozg8oAhDlZgE/FAeUcPaZC2fVi5e
        j7B4B2musqzXMBrQUwYUHe7nzph1NOA=
X-Google-Smtp-Source: AA0mqf6ryhrkk50pc20wBOQ6SQ2+U6uFAyN4HZlykjj7J7fE1VZINRLSuFhERjRhsDPUeiZO6GDUEQ==
X-Received: by 2002:a0c:9061:0:b0:4bb:70e9:7372 with SMTP id o88-20020a0c9061000000b004bb70e97372mr1925247qvo.30.1669078049648;
        Mon, 21 Nov 2022 16:47:29 -0800 (PST)
Received: from debian-BULLSEYE-live-builder-AMD64 (h96-61-90-13.cntcnh.broadband.dynamic.tds.net. [96.61.90.13])
        by smtp.gmail.com with ESMTPSA id q7-20020a05620a0d8700b006f8665f483fsm9348797qkl.85.2022.11.21.16.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 16:47:29 -0800 (PST)
Date:   Mon, 21 Nov 2022 19:47:26 -0500
From:   Eric Whitney <enwlinux@gmail.com>
To:     Eric Whitney <enwlinux@gmail.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu
Subject: Re: [PATCH] ext4: fix delayed allocation bug in ext4_clu_mapped for
 bigalloc + inline
Message-ID: <Y3wcHhbj33n8nw+q@debian-BULLSEYE-live-builder-AMD64>
References: <20221117152207.2424-1-enwlinux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117152207.2424-1-enwlinux@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

* Eric Whitney <enwlinux@gmail.com>:
> When converting files with inline data to extents, delayed allocations
> made on a file system created with both the bigalloc and inline options
> can result in invalid extent status cache content, incorrect reserved
> cluster counts, kernel memory leaks, and potential kernel panics.
> 
> With bigalloc, the code that determines whether a block must be
> delayed allocated searches the extent tree to see if that block maps
> to a previously allocated cluster.  If not, the block is delayed
> allocated, and otherwise, it isn't.  However, if the inline option is
> also used, and if the file containing the block is marked as able to
> store data inline, there isn't a valid extent tree associated with
> the file.  The current code in ext4_clu_mapped() calls
> ext4_find_extent() to search the non-existent tree for a previously
> allocated cluster anyway, which typically finds nothing, as desired.
> However, a side effect of the search can be to cache invalid content
> from the non-existent tree (garbage) in the extent status tree,
> including bogus entries in the pending reservation tree.
> 
> To fix this, avoid searching the extent tree when allocating blocks
> for bigalloc + inline files that are being converted from inline to
> extent mapped.
> 
> Signed-off-by: Eric Whitney <enwlinux@gmail.com>
> ---
>  fs/ext4/extents.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index f1956288307f..a8928d6d47ac 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -5791,6 +5791,14 @@ int ext4_clu_mapped(struct inode *inode, ext4_lblk_t lclu)
>  	struct ext4_extent *extent;
>  	ext4_lblk_t first_lblk, first_lclu, last_lclu;
>  
> +	/*
> +	 * if data can be stored inline, the logical cluster isn't
> +	 * mapped - no physical clusters have been allocated, and the
> +	 * file has no extents
> +	 */
> +	if (ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA))
> +		return 0;
> +
>  	/* search for the extent closest to the first block in the cluster */
>  	path = ext4_find_extent(inode, EXT4_C2B(sbi, lclu), NULL, 0);
>  	if (IS_ERR(path)) {
> -- 
> 2.30.2
> 

The bug this patch addresses was a topic in last week's concall, and on
request here's some more detailed information describing the circumstances
of the test failure I saw.

generic/478 produced a kernel panic during a -g auto run of kvm-xfstests'
bigalloc_inline test configuration.  This was caused by a BUG_ON in
ext4_es_cache_extent, where the value of lblk passed in from
ext4_find_extent -> ext4_cache_extents was 0xffffffff and len was a much
smaller non-zero value.  Running generic/478 alone isn't sufficient to
reproduce the problem - generic/192 must be run first.  That sequence of
tests can be reduced to the following reproducer (in fstest terms):

echo test >$TEST_DIR/testfile

_test_cycle_mount

$XFS_IO_PROG -f -c "pwrite -S 0xFF 0 4096" \
$TEST_DIR/testfile >> $seqres.full 2>&1

What happens as a result of the xfs_io pwrite is that the inline data area is
read from the test file and treated as extents which ext4_find_extent attempts
to cache before proceeding to search for an allocated cluster, as noted above,
at the point in time where the file is being converted from inline to extents.
(All this descends from ext4_da_convert_inline_data_to_extent). The BUG_ON
is triggered because there happens to be an 0xffffffff value in the inline
data area that is interpreted as an lblk.  Before that happens, a few
bogus extents are inserted in the extent status cache.  It seems clear that if
the BUG_ON hadn't been triggered with an appropriate value, execution
would have continued with the possibility of the consequences noted above.

A look at the extent header passed to ext4_cache_extents by
ext4_find_extent reveals a bad magic number which reflects a portion of
the string "test" rather than EXT4_EXT_MAGIC (0xf30a).

Removing the _test_cycle_mount leads to a different result.  The
reproducer executes without triggering a panic.  The difference in this
case is that there is an empty extent tree in place of the inline data;
the magic number is valid.  ext4_find_extent proceeds without caching
anything, and fails to find an allocated cluster for that empty tree.
All at least okay.

So, the difference appears to be that the new extent tree hasn't been set
up before the delayed allocation activity resulting from conversion in
the umount/mount case, and it has when that doesn't take place in the
other case.  I've been looking for the reason.

In either case, there's no point in going through the motions of
searching for a potential cluster mapping at the time of conversion when
there can be no extent tree yet - hence the patch above.  There's also
the possibility of shortcutting this higher in the call chain in
ext4_da_map_blocks (where there's an odd twist - extent status cache
gets searched but extent tree does not before delayed allocation).  For
the moment, doing this in ext4_clu_mapped seems lowest risk.

An aside: wouldn't it make sense to harden ext4_find_extent a little more by
checking eh_magic?

Eric
