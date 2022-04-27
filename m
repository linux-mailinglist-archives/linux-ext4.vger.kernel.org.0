Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6C0511A96
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Apr 2022 16:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238191AbiD0Ohq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 27 Apr 2022 10:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238215AbiD0Ohm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 27 Apr 2022 10:37:42 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D44131572D
        for <linux-ext4@vger.kernel.org>; Wed, 27 Apr 2022 07:34:30 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 23REYQlT020533
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Apr 2022 10:34:26 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id E93E315C3EA1; Wed, 27 Apr 2022 10:34:25 -0400 (EDT)
Date:   Wed, 27 Apr 2022 10:34:25 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [BUG]:OS disk corruption EXT4
Message-ID: <YmlUcTn4x91HYTVK@mit.edu>
References: <20220427043946.GA21120@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220427043946.GA21120@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Apr 26, 2022 at 09:39:46PM -0700, Shradha Gupta wrote:
> I think I may have run into an issue where my ext4 OS disk shows
> multiple corruptions and the issue is reproducible after multiple
> reboots.
> 
> Please help me understand this corruption better as I am new to ext4 layouts. 
> 
> The “fsck -n <device>” command output was as follows:
> 
> e2fsck 1.45.5 (07-Jan-2020)
> ext2fs_open2: Superblock checksum does not match superblock
> fsck.ext4: Superblock invalid, trying backup blocks...
>  Superblock needs_recovery flag is clear, but journal has data.
> Recovery flag not set in backup superblock, so running journal anyway.

You need to give more information; what kernel version are you using?

What is the hardware or cloud VM configuration that you are using?

How are you rebooting the machine?  Are you doing a clean shutdown, or
are you just kicking the plug out of the wall, or killing the VM
without giving a chance for the system to shut down cleanly?

Ext4 should handle an unclean shutdown cleanly, assuming that the
hardware (or emulated disk, in the case of a cloud system) properly
handles CACHE FLUSH requests.

Given the vaguely suggested label on your file system...

> cloudimg-rootfs was not cleanly unmounted, check forced.

Is there anything special going on --- in particular, is this part of
creating a cloud image?  If so, are you doing anything "interesting",
such as updating the Label or UUID using tune2fs racing with, say, an
online resize, or an uncerimonious VM shutdown?

If it is reproducible, can you give us the reproduction recipe?

Thanks,

					- Ted
