Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19DAC535196
	for <lists+linux-ext4@lfdr.de>; Thu, 26 May 2022 17:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347974AbiEZPmu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 26 May 2022 11:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236307AbiEZPmt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 26 May 2022 11:42:49 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12033C8BC2;
        Thu, 26 May 2022 08:42:44 -0700 (PDT)
Received: from zn.tnic (p200300ea97465770329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9746:5770:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 576B61EC0575;
        Thu, 26 May 2022 17:42:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1653579759;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=zCIU4/CyscCWc5T/l1YpTfxCKoddYSUWbPdUmCDxv9k=;
        b=d8Rofdbv9ZG0LzGgzXQKCKGMC9eCn79iMgbbTfjwtw5gi9KJfyKrk+pOWXJqNUfZkQuGG8
        uAy4tuLk46Jvco+yRjUwxk44Mj9IdL7G/cIf4QbLs9C3sez8fHZ/XaqsD5OiEMgxQGxWNR
        qSOVS9luVyAk32btQfrtTwtp5CBgk6o=
Date:   Thu, 26 May 2022 17:42:34 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ritesh Harjani <ritesh.list@gmail.com>
Cc:     linux-ext4 <linux-ext4@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Vaibhav Jain <vaibhav@linux.ibm.com>, Jan Kara <jack@suse.cz>,
        Theodore Ts'o <tytso@mit.edu>
Subject: Re: EXT4-fs error (device sda5) in ext4_update_backup_sb:165:
 Filesystem failed CRC
Message-ID: <Yo+f6ml4jB1jxjfw@zn.tnic>
References: <YmqOqGKajOOx90ZY@zn.tnic>
 <20220526145402.slc4ve5vrlewyutm@riteshh-domain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220526145402.slc4ve5vrlewyutm@riteshh-domain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, May 26, 2022 at 08:24:02PM +0530, Ritesh Harjani wrote:
> Could you please help us understand little more about your setup. Is
> this (sda5) somehow a backup image saved/restored using e2image?

Nah, just a separate, normal partition.

> So, recently I have also been reported with a similar problem, where in filesystem
> image which was saved using e2image on v5.17 kernel (with e2fsck 1.45.5 (07-Jan-2020)).
> Then on upgrading the kernel to v5.18, when this FS image (via e2image) was mounted
> using loop device (or restored to a block device), the above error messages
> were observed.

That could be the case. See, this box is simply a test laptop where I
boot kernels all the time and userspace doesn't get updated, pretty
much. So if old tools massage the superblock and new kernels then touch
it again, that could mean there's some discrepancy there... but what do
I know - I have not clue about fs.

In any case, 5.18-rc7+ didn't have those earlier messages but simply:

EXT4-fs (sda5): warning: mounting fs with errors, running e2fsck is recommended
EXT4-fs (sda5): mounted filesystem with ordered data mode. Quota mode: disabled.

but I haven't run any fsck yet. Since this is a test box, it doesn't
matter a whole lot, though.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
