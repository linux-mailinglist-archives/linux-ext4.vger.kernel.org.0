Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0083C7376
	for <lists+linux-ext4@lfdr.de>; Tue, 13 Jul 2021 17:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237061AbhGMPqC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 13 Jul 2021 11:46:02 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:57274 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236932AbhGMPqC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 13 Jul 2021 11:46:02 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 299DE229CF;
        Tue, 13 Jul 2021 15:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1626190991; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jkBjLUWBZOKdjenUS8Q3EVONyZUbuwv/YH4y9ZQJb2w=;
        b=TdL8Wi+VgrFsTxSsRkTQ6bhpgck2xTgTqJq8Jn4u+RzZ9m8eG3TTg1Y/z/jMwFy+MpQb3w
        z0Z2iKoJ9S9yVz00AJI887q5V3ZneCC5rYvWKlxw6jjlDLUTN35ipL9teNVmJK4c2BtzaC
        x1ymxYike40NPhJ1LU+GVwieZNT3CaM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1626190991;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jkBjLUWBZOKdjenUS8Q3EVONyZUbuwv/YH4y9ZQJb2w=;
        b=BBCsVP9Tw712vAsgVPrDWiT6XIAqfBlD57GafOixi2et8T9agNpO9f/ZnYUmW7Wl3fUTsY
        jwyVFE9mT/QiJcDQ==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 0E0F7A3B85;
        Tue, 13 Jul 2021 15:43:11 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id C8A231E0BBE; Tue, 13 Jul 2021 17:43:10 +0200 (CEST)
Date:   Tue, 13 Jul 2021 17:43:10 +0200
From:   Jan Kara <jack@suse.cz>
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ext4_xattr_ibody_find:2180: inode #2669312: comm
 systemd-journal: corrupted in-inode xattr
Message-ID: <20210713154310.GE24271@quack2.suse.cz>
References: <CAMdYzYqvT+X9C_YZ+DtspgHLSeb=RVHLeS2-0pEHeotyvb+iXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMdYzYqvT+X9C_YZ+DtspgHLSeb=RVHLeS2-0pEHeotyvb+iXQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello!

On Fri 28-05-21 08:36:17, Peter Geis wrote:
> I have run into a fun issue where I have the follow error on boot,
> which causes the device to drop to read only mode:
> ext4_xattr_ibody_find:2180: inode #2669312: comm systemd-journal:
> corrupted in-inode xattr
> It marks the file system as unclean, which forces a fsck, but it seems
> that even as of v1.46.2 e2fsprogs does not have the ability to resolve
> this issue.
> Any attempts to touch the corrupted files (I've found two so far)
> leads to the same error, and I cannot find a way to remove or repair
> the affected inodes without wiping the entire file system.

This seems to have fallen through the cracks. Have you managed to fix your
filesystem? If not, please obtain filesystem image using e2image (it will
contain only fs metadata, not any data), compress it and put it somewhere for
download so that we can better diagnose the issue. Thanks!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
