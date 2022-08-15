Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 444F759518E
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Aug 2022 07:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbiHPFBs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 16 Aug 2022 01:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234628AbiHPFBP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 16 Aug 2022 01:01:15 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26B54F196
        for <linux-ext4@vger.kernel.org>; Mon, 15 Aug 2022 13:56:33 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-49-209-117.bstnma.fios.verizon.net [108.49.209.117])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 27FKuN1n000856
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Aug 2022 16:56:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1660596985; bh=FPmQ7+KASqmRhZVSXfu+kgAWp5LQmPKz4FRQZJYRP9U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=YCg2rMZM8OAjOqcCHM30A9yp1J6T8xLGMwqL+r79/XwAxtVXVIiunK88zmATRMaM9
         kANDI2xf306YWWqJ610nHD3pTdnEPyC/kXYZZXeCyq6i1TVT1ThHIHWhXMma6ML/xz
         zCqCA38ILMyPh8Z/ai1nQj/wlq926aMlFQ7oNxGRZdazqyI9Sfb+ruiiklicHf4uol
         xIpg5+4uYE2j8UPgx7PBRf5UZfvpHHt51U1/drWyHZW0yAJAOId3pYWbpLSrxxM7cp
         0+krMGr8TS+auYSEIWDh2QBTfuTmeboG2s/mjdUp9z0rNXi7x0B7NPi98rFNz4nc3s
         RxKB6a9zc1SCw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 7EC6215C350A; Mon, 15 Aug 2022 16:56:23 -0400 (EDT)
Date:   Mon, 15 Aug 2022 16:56:23 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jeremy Bongio <bongiojp@gmail.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH v3] tune2fs: Add support for get/set UUID ioctls.
Message-ID: <Yvqy93lxTBWGeuxw@mit.edu>
References: <20220719235204.237526-1-bongiojp@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220719235204.237526-1-bongiojp@gmail.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Jul 19, 2022 at 04:52:04PM -0700, Jeremy Bongio wrote:
> +/*
> + * Use EXT4_IOC_GETFSUUID/EXT4_IOC_SETFSUUID to get/set file system UUID.
> + * Return:	0 on success
> + *             -1 when the old method should be used
> + */
> +int handle_fsuuid(__u8 *uuid, bool get)
> +{
> +	errcode_t ret;
> +	int mnt_flags, fd;
> +	char label[FSLABEL_MAX];
> +	int maxlen = FSLABEL_MAX - 1;
> +	char mntpt[PATH_MAX + 1];
> +	struct fsuuid *fsuuid = NULL;
> +
> +	fsuuid = malloc(sizeof(*fsuuid) + UUID_SIZE);
> +	if (!fsuuid)
> +		return -1;

fsuuid is not getting freed in this function, so this will leak
memory.

	...
> +	if (get)
> +		ret = ioctl(fd, EXT4_IOC_GETFSUUID, fsuuid);
> +	else
> +		ret = ioctl(fd, EXT4_IOC_SETFSUUID, fsuuid);

In the EXT4_IOC_GETFSUUID case, you need to copy fsuuid->fsu_uuid to
uuid, so it is returned to the caller.


> +	ret = ext2fs_check_mount_point(device_name, &mnt_flags,
> +					  mntpt, sizeof(mntpt));
> +	if (ret || !(mnt_flags & EXT2_MF_MOUNTED) ||
> +		(!get && (mnt_flags & EXT2_MF_READONLY)) ||
> +		!mntpt[0])
> +		return -1;

handle_fsuuid() is getting called twice by tune2fs when handling the
-U option, which means we're calling ext2fs_check_mount_point() twice.

And around line 3364, tune2fs calls ext2fs_check_if_mounted() which
fetches the mnt_flags but which doesn't get the mountpoint.

So I wonder if wouldn't be better off changing tune2fs's main() to
call ext2fs_check_mount_point() instead of ext2fs_check_if_mounted(),
and we can just determine the mountpoint once.

Then, instead of calling handle_fsuuid/[gs]et_mounted_fsuuid, in the
handling of -U, we can do something like this:

	if (U_flag) {
		int fd = -1;
		struct fsuuid *fsuuid = NULL;
		...

		if ((mnt_flags & EXT2_MF_MOUNTED) &&
		    !(mnt_flags & EXT2_MF_READONLY) && mntpt) {
			fd = open(mntpt, O_RDONLY);
			if (fd >= 0) {
				fsuuid = malloc(sizeof(*fsuuid) + UUID_SIZE);
				if (!fsuuid) {
					close(fd);
					fd = -1;
				}
			}
		}		
				

In other words, we can just inline all of handle_fsuuid, and the call
to get_mounted_fsuuid() just becomes:

	if (fd >= 0) {
		fsuuid->fsu_len - UUID_SIZE;
		fsuuid->fsu_flags = 0;
		ret = ioctl(fd, EXT4_IOC_GETFSUUID, fsuuid);
	}

... and similarly for set_mounted_fsuuid().


Then at the end of tune2fs -U processing, we can do something like this:

	if (fd >= 0)
		close(fd);
	free(fsuuid);

						- Ted
					
