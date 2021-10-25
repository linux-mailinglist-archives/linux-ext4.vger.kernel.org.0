Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16D5D439A75
	for <lists+linux-ext4@lfdr.de>; Mon, 25 Oct 2021 17:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233844AbhJYPbd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 25 Oct 2021 11:31:33 -0400
Received: from mx1.tetaneutral.net ([91.224.149.83]:58566 "EHLO
        mx1.tetaneutral.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233766AbhJYPbc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 25 Oct 2021 11:31:32 -0400
Received: by mx1.tetaneutral.net (Postfix, from userid 109)
        id 84EB18C0CB; Mon, 25 Oct 2021 17:29:06 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mx1.tetaneutral.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,FSL_HELO_NON_FQDN_1
        autolearn=ham autolearn_force=no version=3.4.2
Received: from lgnuc (ip165.tetaneutral.net [IPv6:2a03:7220:8080:a500::1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.tetaneutral.net (Postfix) with ESMTPS id 812588C0A1;
        Mon, 25 Oct 2021 17:29:04 +0200 (CEST)
Message-ID: <1635175743.26818.15.camel@guerby.net>
Subject: Re: How to force EXT4_MB_GRP_CLEAR_TRIMMED on a live ext4?
From:   Laurent GUERBY <laurent@guerby.net>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     linux-ext4@vger.kernel.org
Date:   Mon, 25 Oct 2021 17:29:03 +0200
In-Reply-To: <20211025094227.yio3cjpboxumt5ml@work>
References: <1634984680.26818.10.camel@guerby.net>
         <20211025094227.yio3cjpboxumt5ml@work>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, 2021-10-25 at 11:42 +0200, Lukas Czerner wrote:
> On Sat, Oct 23, 2021 at 12:24:40PM +0200, Laurent GUERBY wrote:
> > 
> > I did end up creating dummy files to fill the filesystem and then
> > removing them, but this is far less efficient than what a
> > filesystem
> > tool could do.
> 
> Yeah, that's bad. The information is stored in the buddy cache in
> memory
> and AFAIK is only dropped on unmount. I'll have to think about how to
> clear either the cache or selectively just the flag.
> 
> What would be more convenient way of doing this for you, -o remount,
> or
> using let's say tune2fs ? I am not promising anything yet, but I'll
> think
> about how to implement it.
> 
> 
> Meanwhile other than umount/mount, or actually writing to the dummy
> files,
> you can try to use fallocate to allocate all the remaining space in
> the
> file system and subsequently removing it. That should be more
> efficient,
> but don't forget to sync after remove to make sure the space is
> released
> before you call fstrim.

Thanks for the advice on fallocate! It does work and is very fast.

I would prefer a specific tune2fs as remount forcing this TRIM cache
clearing behaviour might be unwanted.

> You could also force fsck on ro file system and use -E discard to
> trim the
> free space but I can't say I recommend it.

Thanks again for your help,

Sincerely,

Laurent

