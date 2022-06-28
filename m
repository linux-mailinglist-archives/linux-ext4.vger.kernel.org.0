Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA8555C720
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Jun 2022 14:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244223AbiF1EZS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 28 Jun 2022 00:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243148AbiF1EZK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 28 Jun 2022 00:25:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 31ADC14D16
        for <linux-ext4@vger.kernel.org>; Mon, 27 Jun 2022 21:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656390308;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3ijK1NnuikRq1mIkcXPksBX4gHVTQGnILEVjsTbCrAo=;
        b=HKqD2GJI0ekLqHrKU/Shpn4kS4kHtYW2YsWsD4DcjM2exC1f88TqZbPMgp8pD5tRICDagg
        Al/BhnEKep5phvm2/nzpoYYQynroZWQ/yOEX3m++lz+YU1fl1gQ74hrWgnlQtfagZF1wF5
        JhCEuGSzZAuV122vmjC+cyIO20pt6YA=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-247-uw8jfptmN_Otj-u1e5QNFw-1; Tue, 28 Jun 2022 00:25:04 -0400
X-MC-Unique: uw8jfptmN_Otj-u1e5QNFw-1
Received: by mail-qv1-f69.google.com with SMTP id g29-20020a0caadd000000b004702ed3c3f5so11176915qvb.11
        for <linux-ext4@vger.kernel.org>; Mon, 27 Jun 2022 21:25:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3ijK1NnuikRq1mIkcXPksBX4gHVTQGnILEVjsTbCrAo=;
        b=40nj98Ax0fqujb8lLcbj/5Etne9UqtqJq1I3dJ+AkiD295WC5ddke5ztrmvETUBNGI
         tcjrvlWQYSprL1XDt5sp0yKn21XCJaN0HvElx89ObaLOTW5fEaMqWI7xwGXbrGot4rFJ
         kRjN/jxpxndmhKZ6k+77LP0Gls01rdgCl3gmM5F0NVXSdp1ZN6iuV3IcSxmnef+GdBJY
         bOU6PkcPYPLIZ8GgMxKY4WBT9LXJPqxyvpsZcJbtGhIkDc4Dc3E67kqMCozREwY74p+I
         Mianb7NsvXVYPa8Q6soWrDwqunzLGUgnABfu1SQdK5VW/OrDIV3FSGsF7sJhHw88TjHh
         K3hw==
X-Gm-Message-State: AJIora/WA8ay2zxbsC7ypZ9/1ay94Xv2PUCUguEKXo5AsPky5DfIitPj
        V9rmV6W1lUIBZ/mwrATbala/B5/DOWTpP+pznAoHAPxQeauK8n9C6j3csbimv5gnX/7eQPEo50V
        1oGk4ZxSDy5aX9bcYEJ7ja+v9ypF/Z0WTfuLNXJcJ72Ho3UuIuLa8PLLH368eK10jC+ExpA==
X-Received: by 2002:a05:620a:13a3:b0:6af:a58:c139 with SMTP id m3-20020a05620a13a300b006af0a58c139mr10321941qki.751.1656390303853;
        Mon, 27 Jun 2022 21:25:03 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1s4AlAyTEm1JoSqmH6AueFev8tLDBtcsTzBnzOmNFARg8LIPfzNWwnVb1Quevg+DDkWp5IErw==
X-Received: by 2002:a05:620a:13a3:b0:6af:a58:c139 with SMTP id m3-20020a05620a13a300b006af0a58c139mr10321930qki.751.1656390303524;
        Mon, 27 Jun 2022 21:25:03 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id v15-20020a05620a440f00b006a79aa0c8b1sm10872232qkp.113.2022.06.27.21.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 21:25:02 -0700 (PDT)
Date:   Tue, 28 Jun 2022 12:24:57 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     linux-ext4@vger.kernel.org
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 1/5] ext4/050: support indirect as well as extent mapped
 journals
Message-ID: <20220628042457.zorfs2ghugnilqmm@zlang-mailbox>
References: <20220625030718.1215980-1-tytso@mit.edu>
 <20220625030718.1215980-2-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220625030718.1215980-2-tytso@mit.edu>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Jun 24, 2022 at 11:07:14PM -0400, Theodore Ts'o wrote:
> Simplify the test and fix ext4/050 failures when running ext4 without
> extents enabled (e.g., in ext3 emulation mode).
> 
> Instead of relying on parsing debugfs output's (which varies depending
> on whether the journal inode is extent mapped or indirect block
> mapped), use debugfs's "cat" command to get the contents of the
> journal.
> 
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---

It looks good to me,

Reviewed-by: Zorro Lang <zlang@redhat.com>

But as it contains many ext4 specific format things, so I hope to get one more
reviewing from ext4 mail list, before I merge it.

Thanks,
Zorro

>  tests/ext4/050 | 58 +++++---------------------------------------------
>  1 file changed, 5 insertions(+), 53 deletions(-)
> 
> diff --git a/tests/ext4/050 b/tests/ext4/050
> index 79961957..6f93b86d 100755
> --- a/tests/ext4/050
> +++ b/tests/ext4/050
> @@ -22,55 +22,6 @@ _require_command "$DEBUGFS_PROG" debugfs
>  checkpoint_journal=$here/src/checkpoint_journal
>  _require_test_program "checkpoint_journal"
>  
> -# convert output from stat<journal_inode> to list of block numbers
> -get_journal_extents() {
> -	inode_info=$($DEBUGFS_PROG $SCRATCH_DEV -R "stat <8>" 2>> $seqres.full)
> -	echo -e "\nJournal info:" >> $seqres.full
> -	echo "$inode_info" >> $seqres.full
> -
> -	extents_line=$(echo "$inode_info" | awk '/EXTENTS:/{ print NR; exit }')
> -	get_extents=$(echo "$inode_info" | sed -n "$(($extents_line + 1))"p)
> -
> -	# get just the physical block numbers
> -	get_extents=$(echo "$get_extents" |  perl -pe 's|\(.*?\):||g' | sed -e 's/, /\n/g' | perl -pe 's|(\d+)-(\d+)|\1 \2|g')
> -
> -	echo "$get_extents"
> -}
> -
> -# checks all extents are zero'd out except for the superblock
> -# arg 1: extents (output of get_journal_extents())
> -check_extents() {
> -	echo -e "\nChecking extents:" >> $seqres.full
> -	echo "$1" >> $seqres.full
> -
> -	super_block="true"
> -	echo "$1" | while IFS= read line; do
> -		start_block=$(echo $line | cut -f1 -d' ')
> -		end_block=$(echo $line | cut -f2 -d' ' -s)
> -
> -		# if first block of journal, shouldn't be wiped
> -		if [ "$super_block" == "true" ]; then
> -			super_block="false"
> -
> -			#if super block only block in this extent, skip extent
> -			if [ -z "$end_block" ]; then
> -				continue;
> -			fi
> -			start_block=$(($start_block + 1))
> -		fi
> -
> -		if [ ! -z "$end_block" ]; then
> -			blocks=$(($end_block - $start_block + 1))
> -		else
> -			blocks=1
> -		fi
> -
> -		check=$(od $SCRATCH_DEV --skip-bytes=$(($start_block * $blocksize)) --read-bytes=$(($blocks * $blocksize)) -An -v | sed -e 's/[0 \t\n\r]//g')
> -
> -		[ ! -z "$check" ] && echo "error" && break
> -	done
> -}
> -
>  testdir="${SCRATCH_MNT}/testdir"
>  
>  _scratch_mkfs_sized $((64 * 1024 * 1024)) >> $seqres.full 2>&1
> @@ -93,11 +44,12 @@ sync --file-system $testdir/1
>  # call ioctl to checkpoint and zero-fill journal blocks
>  $checkpoint_journal $SCRATCH_MNT --erase=zeroout || _fail "ioctl returned error"
>  
> -extents=$(get_journal_extents)
> -
>  # check journal blocks zeroed out
> -ret=$(check_extents "$extents")
> -[ "$ret" = "error" ] && _fail "Journal was not zero-filled"
> +$DEBUGFS_PROG $SCRATCH_DEV -R "cat <8>" 2> /dev/null | od >> $seqres.full
> +check=$($DEBUGFS_PROG $SCRATCH_DEV -R "cat <8>" 2> /dev/null | \
> +	    od --skip-bytes="$blocksize" -An -v | sed -e '/^[0 \t]*$/d')
> +
> +[ ! -z "$check" ] && _fail "Journal was not zeroed"
>  
>  _scratch_unmount >> $seqres.full 2>&1
>  
> -- 
> 2.31.0
> 

