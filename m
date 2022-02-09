Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81D194AE630
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Feb 2022 01:43:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240599AbiBIAnU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 8 Feb 2022 19:43:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235164AbiBIAnT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 8 Feb 2022 19:43:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B4CC061576;
        Tue,  8 Feb 2022 16:43:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F27FF61808;
        Wed,  9 Feb 2022 00:43:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53AA7C004E1;
        Wed,  9 Feb 2022 00:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644367396;
        bh=Cz9QL54U3aSL7Xn7qA5+hRNvorHT0oTtmV3RkywSjj8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jOV8YOP53oUFsCMm6jXyy+X//GUZLnLAQZCJtGzMFN14ll7iWc42LSCpEKbMisAne
         KZEdPRysU7B6h7D5rqCVEAy/cFDoFsymjuwXP5OX+ziJMCPf7fcxaS/CA5vrlHOVm5
         1pC7Ob2/5qdm3Q/ZeZFmqnAclTVKK8ZBIMkFYe7eKmws8JQBx8vjPW1iGrr7YSQ9Mv
         YOfj2TBbsea/hJqr+lUyEZ1rutkcitWO8hl1AN4LFZYlt5B1zrR272UU/UT9TAwTbe
         2/SspQ/LfO8Js18YDE3ZtIigzcCpHqVWU/RP9Xw3UO4ivHJ7e2nmB6M+UpPNB/UI6Q
         Ek1vuAJir2GYg==
Date:   Tue, 8 Feb 2022 16:43:16 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH 5/7] common: rename _filter_mkfs to _xfs_filter_mkfs
Message-ID: <20220209004316.GE8288@magnolia>
References: <20220207065541.232685-1-shinichiro.kawasaki@wdc.com>
 <20220207065541.232685-6-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207065541.232685-6-shinichiro.kawasaki@wdc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Feb 07, 2022 at 03:55:39PM +0900, Shin'ichiro Kawasaki wrote:
> The helper function works only for xfs and used only for xfs except
> generic/204. Rename the function to clearly indicate that the function
> is only for xfs.
> 
> Suggested-by: Naohiro Aota <naohiro.aota@wdc.com>
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

<snip the diffstat>

> diff --git a/common/attr b/common/attr
> index 35682d7c..964c790a 100644
> --- a/common/attr
> +++ b/common/attr
> @@ -13,7 +13,7 @@ _acl_get_max()
>  		# CRC format filesystems have much larger ACL counts. The actual
>  		# number is into the thousands, but testing that meany takes too
>  		# long, so just test well past the old limit of 25.
> -		$XFS_INFO_PROG $TEST_DIR | _filter_mkfs > /dev/null 2> $tmp.info
> +		$XFS_INFO_PROG $TEST_DIR | _xfs_filter_mkfs > /dev/null 2> $tmp.info
>  		. $tmp.info
>  		rm $tmp.info
>  		if [ $_fs_has_crcs -eq 0 ]; then
> diff --git a/common/filter b/common/filter
> index c3db7a56..24fd0650 100644
> --- a/common/filter
> +++ b/common/filter
> @@ -117,7 +117,7 @@ _filter_date()
>  
>  # prints filtered output on stdout, values (use eval) on stderr
>  # Non XFS filesystems always return a 4k block size and a 256 byte inode.
> -_filter_mkfs()
> +_xfs_filter_mkfs()
>  {
>      case $FSTYP in
>      xfs)
> diff --git a/common/xfs b/common/xfs

This renames the generic function to be "only for xfs" but it leaves the
non-XFS bits.  Those bits are /really/ problematic (hardcoded
isize=256 and dbsize=4096?  Seriously??) and themselves were introduced
in commit a4d5b247 ("xfstests: Make 204 work with different block and
inode sizes.") oh wow.

I'm sorry that someone left this a mess, but let's try to make it easy
to clean up all the other filesystems, please.  Specifically, could you
please:

1. Hoist the XFS-specific code from _filter_mkfs into a new
   helper _xfs_filter_mkfs() in common/xfs?

--D

> index 713e9fe7..3435c706 100644
> --- a/common/xfs
> +++ b/common/xfs
> @@ -832,7 +832,7 @@ _require_scratch_xfs_shrink()
>  	_require_scratch
>  	_require_command "$XFS_GROWFS_PROG" xfs_growfs
>  
> -	_scratch_mkfs_xfs | _filter_mkfs 2>$tmp.mkfs >/dev/null
> +	_scratch_mkfs_xfs | _xfs_filter_mkfs 2>$tmp.mkfs >/dev/null
>  	. $tmp.mkfs
>  	_scratch_mount
>  	# here just to check if kernel supports, no need do more extra work
> diff --git a/tests/generic/204 b/tests/generic/204
> index b5deb443..40d524d1 100755
> --- a/tests/generic/204
> +++ b/tests/generic/204
> @@ -25,7 +25,7 @@ _supported_fs generic
>  _require_scratch
>  
>  # get the block size first
> -_scratch_mkfs 2> /dev/null | _filter_mkfs 2> $tmp.mkfs > /dev/null
> +_scratch_mkfs 2> /dev/null | _xfs_filter_mkfs 2> $tmp.mkfs > /dev/null
>  . $tmp.mkfs
>  
>  # For xfs, we need to handle the different default log sizes that different
> @@ -37,7 +37,7 @@ _scratch_mkfs 2> /dev/null | _filter_mkfs 2> $tmp.mkfs > /dev/null
>  SIZE=`expr 115 \* 1024 \* 1024`
>  _scratch_mkfs_sized $SIZE $dbsize 2> /dev/null > $tmp.mkfs.raw \
>  	|| _fail "mkfs failed"
> -cat $tmp.mkfs.raw | _filter_mkfs 2> $tmp.mkfs > /dev/null
> +cat $tmp.mkfs.raw | _xfs_filter_mkfs 2> $tmp.mkfs > /dev/null
>  _scratch_mount
>  
>  # Source $tmp.mkfs to get geometry
> diff --git a/tests/xfs/004 b/tests/xfs/004
> index f18316b3..5e83fff9 100755
> --- a/tests/xfs/004
> +++ b/tests/xfs/004
> @@ -21,7 +21,7 @@ _cleanup()
>  _populate_scratch()
>  {
>  	echo "=== mkfs output ===" >>$seqres.full
> -	_scratch_mkfs_xfs | tee -a $seqres.full | _filter_mkfs 2>$tmp.mkfs
> +	_scratch_mkfs_xfs | tee -a $seqres.full | _xfs_filter_mkfs 2>$tmp.mkfs
>  	. $tmp.mkfs
>  	_scratch_mount
>  	# This test looks at specific behaviors of the xfs_db freesp command,
> diff --git a/tests/xfs/007 b/tests/xfs/007
> index 4f864100..33a857e8 100755
> --- a/tests/xfs/007
> +++ b/tests/xfs/007
> @@ -19,7 +19,7 @@ _supported_fs xfs
>  _require_scratch
>  _require_xfs_quota
>  
> -_scratch_mkfs_xfs | _filter_mkfs > /dev/null 2> $tmp.mkfs
> +_scratch_mkfs_xfs | _xfs_filter_mkfs > /dev/null 2> $tmp.mkfs
>  . $tmp.mkfs
>  
>  do_test()
> diff --git a/tests/xfs/010 b/tests/xfs/010
> index 16c08b85..badac7c0 100755
> --- a/tests/xfs/010
> +++ b/tests/xfs/010
> @@ -87,7 +87,7 @@ _require_scratch
>  _require_xfs_mkfs_finobt
>  _require_xfs_finobt
>  
> -_scratch_mkfs_xfs "-m crc=1,finobt=1 -d agcount=2" | _filter_mkfs 2>$seqres.full
> +_scratch_mkfs_xfs "-m crc=1,finobt=1 -d agcount=2" | _xfs_filter_mkfs 2>$seqres.full
>  
>  # sparsely populate the fs such that we create records with free inodes
>  _scratch_mount
> diff --git a/tests/xfs/013 b/tests/xfs/013
> index 2d005753..dc39ffd6 100755
> --- a/tests/xfs/013
> +++ b/tests/xfs/013
> @@ -89,7 +89,7 @@ _require_xfs_finobt
>  _require_command "$KILLALL_PROG" killall
>  
>  _scratch_mkfs_xfs "-m crc=1,finobt=1 -d agcount=2" | \
> -	_filter_mkfs 2>> $seqres.full
> +	_xfs_filter_mkfs 2>> $seqres.full
>  _scratch_mount
>  
>  COUNT=20000	# number of files per directory
> diff --git a/tests/xfs/015 b/tests/xfs/015
> index 2bb7b8d5..72842b38 100755
> --- a/tests/xfs/015
> +++ b/tests/xfs/015
> @@ -44,7 +44,7 @@ _require_fs_space $SCRATCH_MNT 131072
>  _scratch_unmount
>  
>  _scratch_mkfs_sized $((32 * 1024 * 1024)) > $tmp.mkfs.raw || _fail "mkfs failed"
> -cat $tmp.mkfs.raw | _filter_mkfs >$seqres.full 2>$tmp.mkfs
> +cat $tmp.mkfs.raw | _xfs_filter_mkfs >$seqres.full 2>$tmp.mkfs
>  # get original data blocks number and agcount
>  . $tmp.mkfs
>  _scratch_mount
> diff --git a/tests/xfs/016 b/tests/xfs/016
> index 6337bb1f..e8094476 100755
> --- a/tests/xfs/016
> +++ b/tests/xfs/016
> @@ -66,7 +66,7 @@ _init()
>      _scratch_mkfs_xfs $force_opts >$tmp.mkfs0 2>&1
>      [ $? -ne 0 ] && \
>          _notrun "Cannot mkfs for this test using MKFS_OPTIONS specified"
> -    _filter_mkfs <$tmp.mkfs0 >/dev/null 2>$tmp.mkfs
> +    _xfs_filter_mkfs <$tmp.mkfs0 >/dev/null 2>$tmp.mkfs
>      . $tmp.mkfs
>      [ $logsunit -ne 0 ] && \
>          _notrun "Cannot run this test using log MKFS_OPTIONS specified"
> diff --git a/tests/xfs/029 b/tests/xfs/029
> index 6e8aa4db..a3fb9cfc 100755
> --- a/tests/xfs/029
> +++ b/tests/xfs/029
> @@ -36,7 +36,7 @@ _supported_fs xfs
>  _require_scratch
>  
>  echo
> -_scratch_mkfs_xfs | _filter_mkfs 2>/dev/null
> +_scratch_mkfs_xfs | _xfs_filter_mkfs 2>/dev/null
>  
>  echo
>  _scratch_xfs_logprint | filter_logprint
> diff --git a/tests/xfs/030 b/tests/xfs/030
> index 201a9015..62066d06 100755
> --- a/tests/xfs/030
> +++ b/tests/xfs/030
> @@ -83,7 +83,7 @@ $here/src/devzero -v -1 -n "$clear" $SCRATCH_DEV >/dev/null
>  
>  # now kick off the real repair test...
>  #
> -_scratch_mkfs_xfs $DSIZE | _filter_mkfs 2>$tmp.mkfs
> +_scratch_mkfs_xfs $DSIZE | _xfs_filter_mkfs 2>$tmp.mkfs
>  . $tmp.mkfs
>  _check_ag 0
>  _check_ag -1
> diff --git a/tests/xfs/031 b/tests/xfs/031
> index 6e3813da..e6bbc0d4 100755
> --- a/tests/xfs/031
> +++ b/tests/xfs/031
> @@ -82,20 +82,20 @@ echo "$MKFS_OPTIONS" | grep -q "rtinherit" && \
>  _create_proto 0
>  echo "=== one entry (shortform)"
>  _scratch_mkfs_xfs -p $tmp.proto >$tmp.mkfs0 2>&1
> -_filter_mkfs <$tmp.mkfs0 >/dev/null 2>$tmp.mkfs
> +_xfs_filter_mkfs <$tmp.mkfs0 >/dev/null 2>$tmp.mkfs
>  . $tmp.mkfs
>  _check_repair
>  
>  # block-form root directory & repeat
>  _create_proto 20
>  echo "=== twenty entries (block form)"
> -_scratch_mkfs_xfs -p $tmp.proto | _filter_mkfs >/dev/null 2>&1
> +_scratch_mkfs_xfs -p $tmp.proto | _xfs_filter_mkfs >/dev/null 2>&1
>  _check_repair
>  
>  # leaf-form root directory & repeat
>  _create_proto 1000
>  echo "=== thousand entries (leaf form)"
> -_scratch_mkfs_xfs -p $tmp.proto | _filter_mkfs >/dev/null 2>&1
> +_scratch_mkfs_xfs -p $tmp.proto | _xfs_filter_mkfs >/dev/null 2>&1
>  _check_repair
>  
>  # success, all done
> diff --git a/tests/xfs/033 b/tests/xfs/033
> index d47da0d6..61ae4004 100755
> --- a/tests/xfs/033
> +++ b/tests/xfs/033
> @@ -55,10 +55,10 @@ _require_scratch
>  _require_no_large_scratch_dev
>  
>  # devzero blows away 512byte blocks, so make 512byte inodes (at least)
> -_scratch_mkfs_xfs | _filter_mkfs 2>$tmp.mkfs >/dev/null
> +_scratch_mkfs_xfs | _xfs_filter_mkfs 2>$tmp.mkfs >/dev/null
>  . $tmp.mkfs
>  if [ $isize -lt 512 ]; then
> -	_scratch_mkfs_xfs -isize=512 | _filter_mkfs 2>$tmp.mkfs >/dev/null
> +	_scratch_mkfs_xfs -isize=512 | _xfs_filter_mkfs 2>$tmp.mkfs >/dev/null
>  	. $tmp.mkfs
>  fi
>  
> diff --git a/tests/xfs/041 b/tests/xfs/041
> index 05de5578..135ed410 100755
> --- a/tests/xfs/041
> +++ b/tests/xfs/041
> @@ -41,7 +41,7 @@ _do_die_on_error=message_only
>  agsize=32
>  echo -n "Make $agsize megabyte filesystem on SCRATCH_DEV and mount... "
>  _scratch_mkfs_xfs -dsize=${agsize}m,agcount=1 2>&1 >/dev/null || _fail "mkfs failed"
> -bsize=`_scratch_mkfs_xfs -dsize=${agsize}m,agcount=1 2>&1 | _filter_mkfs 2>&1 \
> +bsize=`_scratch_mkfs_xfs -dsize=${agsize}m,agcount=1 2>&1 | _xfs_filter_mkfs 2>&1 \
>  		| perl -ne 'if (/dbsize=(\d+)/) {print $1;}'`
>  onemeginblocks=`expr 1048576 / $bsize`
>  _scratch_mount
> diff --git a/tests/xfs/044 b/tests/xfs/044
> index e66c0cb3..8ffd2af4 100755
> --- a/tests/xfs/044
> +++ b/tests/xfs/044
> @@ -79,7 +79,7 @@ lsize=16777216
>  _scratch_mkfs_xfs -lsize=$lsize,version=$lversion >$tmp.mkfs0 2>&1
>  [ $? -ne 0 ] && \
>      _notrun "Cannot mkfs for this test using MKFS_OPTIONS specified"
> -_filter_mkfs <$tmp.mkfs0 2>$tmp.mkfs1
> +_xfs_filter_mkfs <$tmp.mkfs0 2>$tmp.mkfs1
>  . $tmp.mkfs1
>  [ $lversion -ne 1 ] && \
>      _notrun "Cannot run this test yet using MKFS_OPTIONS specified"
> diff --git a/tests/xfs/050 b/tests/xfs/050
> index 1847611b..3556c85e 100755
> --- a/tests/xfs/050
> +++ b/tests/xfs/050
> @@ -65,7 +65,7 @@ _filter_and_check_blks()
>  
>  _exercise()
>  {
> -	_scratch_mkfs_xfs | _filter_mkfs 2>$tmp.mkfs
> +	_scratch_mkfs_xfs | _xfs_filter_mkfs 2>$tmp.mkfs
>  	cat $tmp.mkfs >>$seqres.full
>  
>  	# keep the blocksize and data size for dd later
> diff --git a/tests/xfs/052 b/tests/xfs/052
> index 75761022..e4c7ee6c 100755
> --- a/tests/xfs/052
> +++ b/tests/xfs/052
> @@ -34,7 +34,7 @@ _require_nobody
>  # setup a default run
>  _qmount_option uquota
>  
> -_scratch_mkfs_xfs | _filter_mkfs 2>$tmp.mkfs
> +_scratch_mkfs_xfs | _xfs_filter_mkfs 2>$tmp.mkfs
>  cat $tmp.mkfs >>$seqres.full
>  chmod a+w $seqres.full     # arbitrary users will write here
>  
> diff --git a/tests/xfs/058 b/tests/xfs/058
> index 8751a7ac..0f87ec3c 100755
> --- a/tests/xfs/058
> +++ b/tests/xfs/058
> @@ -22,7 +22,7 @@ _require_xfs_db_command "fuzz"
>  rm -f "$seqres.full"
>  
>  echo "Format"
> -_scratch_mkfs | _filter_mkfs 2>$tmp.mkfs >> "$seqres.full"
> +_scratch_mkfs | _xfs_filter_mkfs 2>$tmp.mkfs >> "$seqres.full"
>  source $tmp.mkfs
>  
>  do_xfs_db()
> diff --git a/tests/xfs/067 b/tests/xfs/067
> index 3dc381bb..c733d761 100755
> --- a/tests/xfs/067
> +++ b/tests/xfs/067
> @@ -22,7 +22,7 @@ _require_scratch
>  
>  # set up fs for 1K inodes
>  isize=0
> -_scratch_mkfs_xfs | _filter_mkfs >$seqres.full 2>$tmp.mkfs
> +_scratch_mkfs_xfs | _xfs_filter_mkfs >$seqres.full 2>$tmp.mkfs
>  [ $? -eq 0 ] && source $tmp.mkfs
>  if [ "$isize" -lt 1024 ]; then
>      _scratch_mkfs_xfs -i size=1024 >>$seqres.full \
> diff --git a/tests/xfs/070 b/tests/xfs/070
> index 43ca7f84..9db518d7 100755
> --- a/tests/xfs/070
> +++ b/tests/xfs/070
> @@ -76,7 +76,7 @@ _supported_fs xfs
>  _require_scratch_nocheck
>  _require_command "$KILLALL_PROG" killall
>  
> -_scratch_mkfs | _filter_mkfs > /dev/null 2> $tmp.mkfs
> +_scratch_mkfs | _xfs_filter_mkfs > /dev/null 2> $tmp.mkfs
>  test "${PIPESTATUS[0]}" -eq 0 || _fail "mkfs failed"
>  
>  . $tmp.mkfs # import agcount
> diff --git a/tests/xfs/071 b/tests/xfs/071
> index 8373878a..9b425d9f 100755
> --- a/tests/xfs/071
> +++ b/tests/xfs/071
> @@ -81,7 +81,7 @@ _supported_fs xfs
>  [ -n "$XFS_IO_PROG" ] || _notrun "xfs_io executable not found"
>  
>  _require_scratch
> -_scratch_mkfs_xfs | _filter_mkfs 2>$tmp.mkfs
> +_scratch_mkfs_xfs | _xfs_filter_mkfs 2>$tmp.mkfs
>  . $tmp.mkfs
>  echo
>  _scratch_mount
> diff --git a/tests/xfs/073 b/tests/xfs/073
> index c7616b9e..d1b97313 100755
> --- a/tests/xfs/073
> +++ b/tests/xfs/073
> @@ -131,7 +131,7 @@ _verify_copy $imgs.image $SCRATCH_DEV $SCRATCH_MNT
>  echo 
>  echo === copying scratch device to single target, large ro device
>  ${MKFS_XFS_PROG} -dfile,name=$imgs.source,size=100g \
> -	| _filter_mkfs 2>/dev/null
> +	| _xfs_filter_mkfs 2>/dev/null
>  rmdir $imgs.source_dir 2>/dev/null
>  mkdir $imgs.source_dir
>  
> diff --git a/tests/xfs/076 b/tests/xfs/076
> index eac7410e..3cdde79e 100755
> --- a/tests/xfs/076
> +++ b/tests/xfs/076
> @@ -61,7 +61,7 @@ _require_xfs_io_command "fpunch"
>  _require_xfs_sparse_inodes
>  
>  _scratch_mkfs "-d size=50m -m crc=1 -i sparse" |
> -	_filter_mkfs > /dev/null 2> $tmp.mkfs
> +	_xfs_filter_mkfs > /dev/null 2> $tmp.mkfs
>  . $tmp.mkfs	# for isize
>  
>  _scratch_mount
> diff --git a/tests/xfs/078 b/tests/xfs/078
> index 1f475c96..a3b75fa6 100755
> --- a/tests/xfs/078
> +++ b/tests/xfs/078
> @@ -74,7 +74,7 @@ _grow_loop()
>  		mkfs_crc_opts="-m crc=0"
>  	fi
>  	$MKFS_XFS_PROG $mkfs_crc_opts -b size=$bsize $dparam $LOOP_DEV \
> -		| _filter_mkfs 2>/dev/null
> +		| _xfs_filter_mkfs 2>/dev/null
>  
>  	echo "*** extend loop file"
>  	_destroy_loop_device $LOOP_DEV
> diff --git a/tests/xfs/092 b/tests/xfs/092
> index 015149e2..7e7b31fc 100755
> --- a/tests/xfs/092
> +++ b/tests/xfs/092
> @@ -20,7 +20,7 @@ _require_scratch
>  _require_no_large_scratch_dev
>  
>  MOUNT_OPTIONS="$MOUNT_OPTIONS -o inode64"
> -_scratch_mkfs_xfs | _filter_mkfs 2>/dev/null
> +_scratch_mkfs_xfs | _xfs_filter_mkfs 2>/dev/null
>  echo Silence is golden
>  
>  _try_scratch_mount
> diff --git a/tests/xfs/104 b/tests/xfs/104
> index d16f46d8..c21bd4e0 100755
> --- a/tests/xfs/104
> +++ b/tests/xfs/104
> @@ -15,7 +15,7 @@ _begin_fstest growfs ioctl prealloc auto stress
>  _create_scratch()
>  {
>  	echo "*** mkfs"
> -	_scratch_mkfs_xfs $@ | tee -a $seqres.full | _filter_mkfs 2>$tmp.mkfs
> +	_scratch_mkfs_xfs $@ | tee -a $seqres.full | _xfs_filter_mkfs 2>$tmp.mkfs
>  	. $tmp.mkfs
>  
>  	echo "*** mount"
> @@ -50,7 +50,7 @@ _supported_fs xfs
>  _require_scratch
>  _require_xfs_io_command "falloc"
>  
> -_scratch_mkfs_xfs | tee -a $seqres.full | _filter_mkfs 2>$tmp.mkfs
> +_scratch_mkfs_xfs | tee -a $seqres.full | _xfs_filter_mkfs 2>$tmp.mkfs
>  . $tmp.mkfs	# extract blocksize and data size for scratch device
>  
>  endsize=`expr 550 \* 1048576`	# stop after growing this big
> @@ -89,7 +89,7 @@ while [ $size -le $endsize ]; do
>  	echo "*** growing filesystem"
>  	echo "*** growing to a ${sizeb} block filesystem" >> $seqres.full
>  	xfs_growfs -D ${sizeb} $SCRATCH_MNT \
> -		| tee -a $seqres.full | _filter_mkfs 2>$tmp.growfs
> +		| tee -a $seqres.full | _xfs_filter_mkfs 2>$tmp.growfs
>  	. $tmp.growfs
>  	[ `expr $size % $modsize` -eq 0 ] && wait	# every 4th iteration
>  	echo AGCOUNT=$agcount | tee -a $seqres.full
> diff --git a/tests/xfs/108 b/tests/xfs/108
> index 46070005..985b989b 100755
> --- a/tests/xfs/108
> +++ b/tests/xfs/108
> @@ -62,7 +62,7 @@ _require_prjquota $SCRATCH_DEV
>  # real QA test starts here
>  rm -f $tmp.projects $seqres.full
>  _scratch_unmount 2>/dev/null
> -_scratch_mkfs_xfs | _filter_mkfs 2>$tmp.mkfs
> +_scratch_mkfs_xfs | _xfs_filter_mkfs 2>$tmp.mkfs
>  cat $tmp.mkfs >>$seqres.full
>  _scratch_mount
>  
> diff --git a/tests/xfs/109 b/tests/xfs/109
> index 6cb6917a..e29d4795 100755
> --- a/tests/xfs/109
> +++ b/tests/xfs/109
> @@ -78,7 +78,7 @@ if [ -n "$FASTSTART" -a -f $SCRATCH_MNT/f0 ]; then
>  fi
>  _scratch_unmount
>  
> -_scratch_mkfs_xfs -dsize=160m,agcount=4 $faststart | _filter_mkfs 2>$tmp.mkfs
> +_scratch_mkfs_xfs -dsize=160m,agcount=4 $faststart | _xfs_filter_mkfs 2>$tmp.mkfs
>  cat $tmp.mkfs >>$seqres.full
>  _scratch_mount
>  
> diff --git a/tests/xfs/110 b/tests/xfs/110
> index 596057ef..734d2869 100755
> --- a/tests/xfs/110
> +++ b/tests/xfs/110
> @@ -18,7 +18,7 @@ _require_scratch
>  
>  # real QA test starts here
>  _scratch_unmount 2>/dev/null
> -_scratch_mkfs_xfs | _filter_mkfs 2>$tmp.mkfs
> +_scratch_mkfs_xfs | _xfs_filter_mkfs 2>$tmp.mkfs
>  
>  STR1=AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
>  STR2=BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB
> diff --git a/tests/xfs/111 b/tests/xfs/111
> index ede28aee..ed5a54c5 100755
> --- a/tests/xfs/111
> +++ b/tests/xfs/111
> @@ -22,7 +22,7 @@ _require_scratch
>  _scratch_unmount 2>/dev/null
>  MKFS_OPTIONS="-bsize=4096"
>  MOUNT_OPTIONS="-o noatime"
> -_scratch_mkfs_xfs | _filter_mkfs 2>$tmp.mkfs
> +_scratch_mkfs_xfs | _xfs_filter_mkfs 2>$tmp.mkfs
>  _scratch_mount
>  
>  echo Create some files
> diff --git a/tests/xfs/144 b/tests/xfs/144
> index 5abec9ae..d46eb1e2 100755
> --- a/tests/xfs/144
> +++ b/tests/xfs/144
> @@ -24,7 +24,7 @@ _require_xfs_quota
>  _require_scratch
>  
>  exercise() {
> -	_scratch_mkfs_xfs | _filter_mkfs 2>$tmp.mkfs
> +	_scratch_mkfs_xfs | _xfs_filter_mkfs 2>$tmp.mkfs
>  	cat $tmp.mkfs >>$seqres.full
>  
>  	# keep the blocksize and data size for dd later
> diff --git a/tests/xfs/153 b/tests/xfs/153
> index 37303701..d410cbed 100755
> --- a/tests/xfs/153
> +++ b/tests/xfs/153
> @@ -70,7 +70,7 @@ _filter_and_check_blks()
>  
>  run_tests()
>  {
> -	_scratch_mkfs_xfs | _filter_mkfs 2>$tmp.mkfs
> +	_scratch_mkfs_xfs | _xfs_filter_mkfs 2>$tmp.mkfs
>  	cat $tmp.mkfs >>$seqres.full
>  
>  	# keep the blocksize and data size for dd later
> diff --git a/tests/xfs/163 b/tests/xfs/163
> index 9f6dbeb8..79f420fa 100755
> --- a/tests/xfs/163
> +++ b/tests/xfs/163
> @@ -24,7 +24,7 @@ test_shrink()
>  	_check_scratch_fs
>  	_scratch_mount
>  
> -	$XFS_INFO_PROG $SCRATCH_MNT 2>&1 | _filter_mkfs 2>$tmp.growfs >/dev/null
> +	$XFS_INFO_PROG $SCRATCH_MNT 2>&1 | _xfs_filter_mkfs 2>$tmp.growfs >/dev/null
>  	. $tmp.growfs
>  	[ $ret -eq 0 -a $1 -eq $dblocks ]
>  }
> @@ -38,7 +38,7 @@ echo "Format and mount"
>  # agcount = 1 is forbidden on purpose, and need to ensure shrinking to
>  # 2 AGs isn't feasible yet. So agcount = 3 is the minimum number now.
>  _scratch_mkfs -dsize="$((512 * 1024 * 1024))" -dagcount=3 2>&1 | \
> -	tee -a $seqres.full | _filter_mkfs 2>$tmp.mkfs >/dev/null
> +	tee -a $seqres.full | _xfs_filter_mkfs 2>$tmp.mkfs >/dev/null
>  . $tmp.mkfs
>  t_dblocks=$dblocks
>  _scratch_mount >> $seqres.full
> diff --git a/tests/xfs/168 b/tests/xfs/168
> index ffcd0df8..6b3eee30 100755
> --- a/tests/xfs/168
> +++ b/tests/xfs/168
> @@ -19,7 +19,7 @@ _begin_fstest auto growfs shrinkfs ioctl prealloc stress
>  create_scratch()
>  {
>  	_scratch_mkfs_xfs $@ | tee -a $seqres.full | \
> -		_filter_mkfs 2>$tmp.mkfs >/dev/null
> +		_xfs_filter_mkfs 2>$tmp.mkfs >/dev/null
>  	. $tmp.mkfs
>  
>  	_scratch_mount
> @@ -48,7 +48,7 @@ _supported_fs xfs
>  _require_scratch_xfs_shrink
>  _require_xfs_io_command "falloc"
>  
> -_scratch_mkfs_xfs | tee -a $seqres.full | _filter_mkfs 2>$tmp.mkfs >/dev/null
> +_scratch_mkfs_xfs | tee -a $seqres.full | _xfs_filter_mkfs 2>$tmp.mkfs >/dev/null
>  . $tmp.mkfs	# extract blocksize and data size for scratch device
>  
>  endsize=`expr 125 \* 1048576`	# stop after shrinking this big
> @@ -93,7 +93,7 @@ while [ $totalcount -gt 0 ]; do
>  		[ $decb -eq 0 ] && break
>  
>  		# get latest dblocks
> -		$XFS_INFO_PROG $SCRATCH_MNT 2>&1 | _filter_mkfs 2>$tmp.growfs >/dev/null
> +		$XFS_INFO_PROG $SCRATCH_MNT 2>&1 | _xfs_filter_mkfs 2>$tmp.growfs >/dev/null
>  		. $tmp.growfs
>  
>  		size=`expr $dblocks \* $dbsize`
> diff --git a/tests/xfs/176 b/tests/xfs/176
> index ba4aae59..57e11fd7 100755
> --- a/tests/xfs/176
> +++ b/tests/xfs/176
> @@ -24,7 +24,7 @@ _require_xfs_io_command "falloc"
>  _require_xfs_io_command "fpunch"
>  
>  _scratch_mkfs "-d size=50m -m crc=1 -i sparse" |
> -	_filter_mkfs > /dev/null 2> $tmp.mkfs
> +	_xfs_filter_mkfs > /dev/null 2> $tmp.mkfs
>  . $tmp.mkfs	# for isize
>  cat $tmp.mkfs >> $seqres.full
>  
> diff --git a/tests/xfs/178 b/tests/xfs/178
> index a65197cd..5392b9bb 100755
> --- a/tests/xfs/178
> +++ b/tests/xfs/178
> @@ -45,7 +45,7 @@ _supported_fs xfs
>  #             fix filesystem, new mkfs.xfs will be fine.
>  
>  _require_scratch
> -_scratch_mkfs_xfs | _filter_mkfs 2>$tmp.mkfs
> +_scratch_mkfs_xfs | _xfs_filter_mkfs 2>$tmp.mkfs
>  test "${PIPESTATUS[0]}" -eq 0 || _fail "mkfs failed!"
>  
>  # By executing the followint tmp file, will get on the mkfs options stored in
> diff --git a/tests/xfs/186 b/tests/xfs/186
> index b54fcf26..8a2a6995 100755
> --- a/tests/xfs/186
> +++ b/tests/xfs/186
> @@ -124,7 +124,7 @@ _require_scratch
>  _require_attrs
>  _require_attr_v1
>  
> -_scratch_mkfs -i attr=2,size=512 -l lazy-count=1 | _filter_mkfs \
> +_scratch_mkfs -i attr=2,size=512 -l lazy-count=1 | _xfs_filter_mkfs \
>  	>>$seqres.full 2>$tmp.mkfs
>  # import crc status and attr version
>  . $tmp.mkfs
> diff --git a/tests/xfs/189 b/tests/xfs/189
> index e601881a..437243c7 100755
> --- a/tests/xfs/189
> +++ b/tests/xfs/189
> @@ -231,7 +231,7 @@ _require_noattr2
>  unset SCRATCH_RTDEV
>  unset SCRATCH_LOGDEV
>  
> -_scratch_mkfs_xfs | _filter_mkfs 2>/dev/null
> +_scratch_mkfs_xfs | _xfs_filter_mkfs 2>/dev/null
>  
>  _add_scratch_fstab
>  _test_remount_rw
> diff --git a/tests/xfs/250 b/tests/xfs/250
> index 8af32711..573340bb 100755
> --- a/tests/xfs/250
> +++ b/tests/xfs/250
> @@ -54,7 +54,7 @@ _test_loop()
>  
>  	echo "*** mkfs loop file (size=$size)"
>  	$MKFS_XFS_PROG -d $dparam \
> -		| _filter_mkfs 2>/dev/null
> +		| _xfs_filter_mkfs 2>/dev/null
>  
>  	echo "*** mount loop filesystem"
>  	mount -t xfs -o loop $LOOP_DEV $LOOP_MNT
> diff --git a/tests/xfs/259 b/tests/xfs/259
> index 88e2f3ee..7c062c7d 100755
> --- a/tests/xfs/259
> +++ b/tests/xfs/259
> @@ -49,7 +49,7 @@ for del in $sizes_to_check; do
>  			>/dev/null 2>&1 || echo "dd failed"
>  		lofile=$(losetup -f)
>  		losetup $lofile "$testfile"
> -		$MKFS_XFS_PROG -l size=32m -b size=$bs $lofile |  _filter_mkfs \
> +		$MKFS_XFS_PROG -l size=32m -b size=$bs $lofile |  _xfs_filter_mkfs \
>  			>/dev/null 2> $tmp.mkfs || echo "mkfs failed!"
>  		. $tmp.mkfs
>  		sync
> diff --git a/tests/xfs/276 b/tests/xfs/276
> index 8cc48675..6774b819 100755
> --- a/tests/xfs/276
> +++ b/tests/xfs/276
> @@ -29,7 +29,7 @@ _require_test_program "punch-alternating"
>  rm -f "$seqres.full"
>  
>  echo "Format and mount"
> -_scratch_mkfs | _filter_mkfs 2> "$tmp.mkfs" >/dev/null
> +_scratch_mkfs | _xfs_filter_mkfs 2> "$tmp.mkfs" >/dev/null
>  . $tmp.mkfs
>  cat "$tmp.mkfs" > $seqres.full
>  _scratch_mount
> diff --git a/tests/xfs/279 b/tests/xfs/279
> index 835d187f..64563237 100755
> --- a/tests/xfs/279
> +++ b/tests/xfs/279
> @@ -44,7 +44,7 @@ _check_mkfs()
>  		return
>  	fi
>  	echo "Passed."
> -	cat $tmp.mkfs.full | _filter_mkfs >> $seqres.full 2>$tmp.mkfs
> +	cat $tmp.mkfs.full | _xfs_filter_mkfs >> $seqres.full 2>$tmp.mkfs
>  	. $tmp.mkfs
>  	echo "Got sector size: $sectsz"
>  	device=`echo $@ | awk '{print $NF}'`
> diff --git a/tests/xfs/288 b/tests/xfs/288
> index e3d230e9..ec12d0d1 100755
> --- a/tests/xfs/288
> +++ b/tests/xfs/288
> @@ -20,7 +20,7 @@ _require_scratch
>  _require_attrs
>  
>  # get block size ($dbsize) from the mkfs output
> -_scratch_mkfs_xfs 2>/dev/null | _filter_mkfs 2>$tmp.mkfs >/dev/null
> +_scratch_mkfs_xfs 2>/dev/null | _xfs_filter_mkfs 2>$tmp.mkfs >/dev/null
>  . $tmp.mkfs
>  
>  _scratch_mount
> diff --git a/tests/xfs/292 b/tests/xfs/292
> index cf501571..930504ca 100755
> --- a/tests/xfs/292
> +++ b/tests/xfs/292
> @@ -25,12 +25,12 @@ rm -f $fsfile
>  $XFS_IO_PROG -f -c "truncate 256g" $fsfile
>  
>  echo "mkfs.xfs without geometry"
> -mkfs.xfs -f $fsfile | _filter_mkfs 2> $tmp.mkfs > /dev/null
> +mkfs.xfs -f $fsfile | _xfs_filter_mkfs 2> $tmp.mkfs > /dev/null
>  grep -E 'ddev|agcount|agsize' $tmp.mkfs | \
>      sed -e "s:$fsfile:FILENAME:g"
>  
>  echo "mkfs.xfs with cmdline geometry"
> -mkfs.xfs -f -d su=16k,sw=5 $fsfile | _filter_mkfs 2> $tmp.mkfs > /dev/null
> +mkfs.xfs -f -d su=16k,sw=5 $fsfile | _xfs_filter_mkfs 2> $tmp.mkfs > /dev/null
>  grep -E 'ddev|agcount|agsize' $tmp.mkfs | \
>      sed -e "s:$fsfile:FILENAME:g"
>  
> diff --git a/tests/xfs/299 b/tests/xfs/299
> index a3077b0c..e6da413a 100755
> --- a/tests/xfs/299
> +++ b/tests/xfs/299
> @@ -147,7 +147,7 @@ _exercise()
>  
>  }
>  
> -_scratch_mkfs_xfs -m crc=1 2>/dev/null | _filter_mkfs 2>$tmp.mkfs
> +_scratch_mkfs_xfs -m crc=1 2>/dev/null | _xfs_filter_mkfs 2>$tmp.mkfs
>  cat $tmp.mkfs >>$seqres.full
>  # keep the blocksize and data size for dd later
>  . $tmp.mkfs
> @@ -184,7 +184,7 @@ _exercise u
>  echo "*** unmount"
>  _scratch_unmount
>  
> -_scratch_mkfs_xfs -m crc=1 2>/dev/null | _filter_mkfs 2>$tmp.mkfs
> +_scratch_mkfs_xfs -m crc=1 2>/dev/null | _xfs_filter_mkfs 2>$tmp.mkfs
>  cat $tmp.mkfs >>$seqres.full
>  # keep the blocksize and data size for dd later
>  . $tmp.mkfs
> diff --git a/tests/xfs/335 b/tests/xfs/335
> index ccc508e7..c2bb1bde 100755
> --- a/tests/xfs/335
> +++ b/tests/xfs/335
> @@ -22,7 +22,7 @@ _require_xfs_io_command "falloc"
>  rm -f "$seqres.full"
>  
>  echo "Format and mount"
> -_scratch_mkfs | _filter_mkfs 2>$tmp.mkfs >/dev/null
> +_scratch_mkfs | _xfs_filter_mkfs 2>$tmp.mkfs >/dev/null
>  . $tmp.mkfs
>  cat $tmp.mkfs > "$seqres.full" 2>&1
>  _scratch_mount
> diff --git a/tests/xfs/336 b/tests/xfs/336
> index 279830b5..19ed8cc6 100755
> --- a/tests/xfs/336
> +++ b/tests/xfs/336
> @@ -29,7 +29,7 @@ _require_xfs_io_command "falloc"
>  rm -f "$seqres.full"
>  
>  echo "Format and mount"
> -_scratch_mkfs | _filter_mkfs 2>$tmp.mkfs >/dev/null
> +_scratch_mkfs | _xfs_filter_mkfs 2>$tmp.mkfs >/dev/null
>  . $tmp.mkfs
>  cat $tmp.mkfs > "$seqres.full" 2>&1
>  _scratch_mount
> diff --git a/tests/xfs/337 b/tests/xfs/337
> index a2515e36..ca476e28 100755
> --- a/tests/xfs/337
> +++ b/tests/xfs/337
> @@ -23,7 +23,7 @@ _disable_dmesg_check
>  rm -f "$seqres.full"
>  
>  echo "+ create scratch fs"
> -_scratch_mkfs | _filter_mkfs 2>$tmp.mkfs >/dev/null
> +_scratch_mkfs | _xfs_filter_mkfs 2>$tmp.mkfs >/dev/null
>  . $tmp.mkfs
>  cat $tmp.mkfs > "$seqres.full" 2>&1
>  
> diff --git a/tests/xfs/341 b/tests/xfs/341
> index f026aa37..dad1e0af 100755
> --- a/tests/xfs/341
> +++ b/tests/xfs/341
> @@ -23,7 +23,7 @@ _require_xfs_io_command "falloc"
>  rm -f "$seqres.full"
>  
>  echo "Format and mount"
> -_scratch_mkfs | _filter_mkfs 2>$tmp.mkfs >/dev/null
> +_scratch_mkfs | _xfs_filter_mkfs 2>$tmp.mkfs >/dev/null
>  . $tmp.mkfs
>  cat $tmp.mkfs > "$seqres.full" 2>&1
>  _scratch_mount
> diff --git a/tests/xfs/342 b/tests/xfs/342
> index 1ae414eb..0922b3fe 100755
> --- a/tests/xfs/342
> +++ b/tests/xfs/342
> @@ -22,7 +22,7 @@ _require_xfs_io_command "falloc"
>  rm -f "$seqres.full"
>  
>  echo "Format and mount"
> -_scratch_mkfs | _filter_mkfs 2>$tmp.mkfs >/dev/null
> +_scratch_mkfs | _xfs_filter_mkfs 2>$tmp.mkfs >/dev/null
>  . $tmp.mkfs
>  cat $tmp.mkfs > "$seqres.full" 2>&1
>  _scratch_mount
> diff --git a/tests/xfs/443 b/tests/xfs/443
> index f2390bf3..a236c8f8 100755
> --- a/tests/xfs/443
> +++ b/tests/xfs/443
> @@ -31,7 +31,7 @@ _require_xfs_io_command "falloc"
>  _require_xfs_io_command "fpunch"
>  _require_xfs_io_command "swapext"
>  
> -_scratch_mkfs | _filter_mkfs >> $seqres.full 2> $tmp.mkfs
> +_scratch_mkfs | _xfs_filter_mkfs >> $seqres.full 2> $tmp.mkfs
>  _scratch_mount
>  
>  # get fs block size
> diff --git a/tests/xfs/448 b/tests/xfs/448
> index 815f56cb..3cd56d4d 100755
> --- a/tests/xfs/448
> +++ b/tests/xfs/448
> @@ -34,7 +34,7 @@ _require_no_xfs_bug_on_assert
>  rm -f "$seqres.full"
>  
>  # Format and mount
> -_scratch_mkfs | _filter_mkfs > $seqres.full 2> $tmp.mkfs
> +_scratch_mkfs | _xfs_filter_mkfs > $seqres.full 2> $tmp.mkfs
>  test "${PIPESTATUS[0]}" -eq 0 || _fail "mkfs failed"
>  _scratch_mount
>  
> diff --git a/tests/xfs/490 b/tests/xfs/490
> index 8c3b0684..08a03261 100755
> --- a/tests/xfs/490
> +++ b/tests/xfs/490
> @@ -37,7 +37,7 @@ filter_dmesg()
>  # If enable free inode B+tree, this case will fail on xfs_dialloc_ag_update_inobt,
>  # that's not what we want to test. Due to finobt feature is not necessary for this
>  # test, so disable it directly.
> -_scratch_mkfs_xfs -m finobt=0 | _filter_mkfs 2>$tmp.mkfs >> $seqres.full
> +_scratch_mkfs_xfs -m finobt=0 | _xfs_filter_mkfs 2>$tmp.mkfs >> $seqres.full
>  
>  # On V5 filesystem, this case can't trigger bug because it doesn't read inodes
>  # we are allocating from disk - it simply overwrites them with new inode
> diff --git a/tests/xfs/502 b/tests/xfs/502
> index fb9a82c1..464326cc 100755
> --- a/tests/xfs/502
> +++ b/tests/xfs/502
> @@ -25,7 +25,7 @@ _require_xfs_io_error_injection "iunlink_fallback"
>  _require_scratch
>  _require_test_program "t_open_tmpfiles"
>  
> -_scratch_mkfs | _filter_mkfs 2> $tmp.mkfs > /dev/null
> +_scratch_mkfs | _xfs_filter_mkfs 2> $tmp.mkfs > /dev/null
>  cat $tmp.mkfs >> $seqres.full
>  . $tmp.mkfs
>  
> diff --git a/tests/xfs/513 b/tests/xfs/513
> index bfdfd4f6..a13f0a03 100755
> --- a/tests/xfs/513
> +++ b/tests/xfs/513
> @@ -68,7 +68,7 @@ MKFS_OPTIONS=""
>  do_mkfs()
>  {
>  	echo "FORMAT: $@" | filter_loop | tee -a $seqres.full
> -	$MKFS_XFS_PROG -f $* $LOOP_DEV | _filter_mkfs >>$seqres.full 2>$tmp.mkfs
> +	$MKFS_XFS_PROG -f $* $LOOP_DEV | _xfs_filter_mkfs >>$seqres.full 2>$tmp.mkfs
>  	if [ "${PIPESTATUS[0]}" -ne 0 ]; then
>  		_fail "Fails on _mkfs_dev $* $LOOP_DEV"
>  	fi
> diff --git a/tests/xfs/530 b/tests/xfs/530
> index 9c6f44d7..925a7b49 100755
> --- a/tests/xfs/530
> +++ b/tests/xfs/530
> @@ -38,7 +38,7 @@ _require_scratch_nocheck
>  
>  echo "* Test extending rt inodes"
>  
> -_scratch_mkfs | _filter_mkfs >> $seqres.full 2> $tmp.mkfs
> +_scratch_mkfs | _xfs_filter_mkfs >> $seqres.full 2> $tmp.mkfs
>  . $tmp.mkfs
>  
>  echo "Create fake rt volume"
> diff --git a/tests/xfs/533 b/tests/xfs/533
> index b85b5298..c7d470c9 100755
> --- a/tests/xfs/533
> +++ b/tests/xfs/533
> @@ -23,7 +23,7 @@ _require_test_program "punch-alternating"
>  _require_xfs_io_error_injection "reduce_max_iextents"
>  _require_xfs_io_error_injection "bmap_alloc_minlen_extent"
>  
> -_scratch_mkfs_sized $((1024 * 1024 * 1024)) | _filter_mkfs >> $seqres.full 2> $tmp.mkfs
> +_scratch_mkfs_sized $((1024 * 1024 * 1024)) | _xfs_filter_mkfs >> $seqres.full 2> $tmp.mkfs
>  . $tmp.mkfs
>  
>  # Filesystems with directory block size greater than one FSB will not be tested,
> -- 
> 2.34.1
> 
