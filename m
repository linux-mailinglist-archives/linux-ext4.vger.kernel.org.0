Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A873D3B8C09
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Jul 2021 04:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238603AbhGACUX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 30 Jun 2021 22:20:23 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:43537 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234257AbhGACUX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 30 Jun 2021 22:20:23 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id DAB34580B8B;
        Wed, 30 Jun 2021 22:17:52 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 30 Jun 2021 22:17:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        joshtriplett.org; h=date:from:to:cc:subject:message-id
        :references:mime-version:content-type:in-reply-to; s=fm1; bh=5VV
        ELhPFxTBkOfKL82zuBqsYKxXKbip1GBt06pE8ZeE=; b=HvE48WPUd5kdNQQ834R
        bPKTK51UNaJJn00uerLB9VdcEEsQN8EYAeQR7C5dsyzZ5b/IbK5nJ0PrPv3GcGyp
        UG58uWm8MeeiBO/Ls5XW2vL/KMLIacZJm5ZbMq73ryJ0eXWDwl042Te2TpKjtrw+
        iLKf+Q0rr6aRugR0xdNhcNniYCezItSxmpLU/6ZUBqr51NFNMFwEY+X/lGG90j2Q
        FTVqLlhxcnaO3ogG+Y9SZ1yiAVwdqmtNgd6nhOtj9Q+FaaHR+GszGExPNkml7SUT
        4rsPBssVXIv6myrA+ZbeMiXJPOUqxf1pbJfRXL8CqlI4AJA/Ikeh3AFcN5cogjl/
        t3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=5VVELh
        PFxTBkOfKL82zuBqsYKxXKbip1GBt06pE8ZeE=; b=dHngx8H82rDmiMpc0U03jF
        h4HtTtAP6unHRJQSmvb3tFwZts5GcJZ/bHqFKzeGnJHgArW1TFKnul/R4N8Bfj5b
        L2jqunqMh4NZQp4oKjEAklzy5JRtRHNzMOvxRbZ5hp2kExgjad7e7m2f9UduAENT
        ArsxBg9D1jw65uyXvhCKSypPA8wCPzaN0tA+RBlvyj8Zby7xzyQUT7LB3n3q+fb3
        JlbVw4GNJVH7qDmAmn6bLQmVRDK8eShddrgEesJTZSJ63K4wH2Dl7hZNCW5K8Wap
        QxUzsKtlRJXf9+7rpdjTQdlSR/z6yk4vioz6QPqM3w8KGyMH2AhD/rCysBpF4WAA
        ==
X-ME-Sender: <xms:zyXdYE7Vibnb1BcH83om8-v0gfkd1B4fEn2jG5PIin4eYAs9V4OELg>
    <xme:zyXdYF4CMmUm7kIHC-iFFTMxCOyGc6CADjzYlLhbA7ArUBp9ncmGehTkz4xEIQDbb
    Fd8Gh_Pvl9pWcaUFmY>
X-ME-Received: <xmr:zyXdYDfOc66Afixo76_lpl2gfW-BYsqiE7iZx3UTIzNpvNcdUosNkJtalN0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeeihedgheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesthdtre
    dttddtvdenucfhrhhomheplfhoshhhucfvrhhiphhlvghtthcuoehjohhshhesjhhoshhh
    thhrihhplhgvthhtrdhorhhgqeenucggtffrrghtthgvrhhnpeegtdfgfeeghfevgeelgf
    efieegudeuheekkedtueeutefgheffveegueeiteehteenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjohhshhesjhhoshhhthhrihhplhgvth
    htrdhorhhg
X-ME-Proxy: <xmx:zyXdYJKjK2Sqv6z6JftJgiPliQ31SmyR0VpF4-7RKxvIPwnwjwSMsw>
    <xmx:zyXdYIKVZX4S0RHsT1jqfgF5i86BxbdmgaCqqhvOFXjdBy61NRim7Q>
    <xmx:zyXdYKwQUiZ7FqdQnm-YSjx5xFKhlW9jlmbt5-HuhJGZB5FLeFCocQ>
    <xmx:0CXdYPUQiXlu3VxsLrfAcQm5Q6deGXZZanr5xgYCHtvXkPnu3QpdbQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Jun 2021 22:17:51 -0400 (EDT)
Date:   Wed, 30 Jun 2021 19:17:50 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>
Subject: Re: [PATCH 1/2] fs: ext4: Consolidate checks for resize of bigalloc
 into ext4_resize_begin
Message-ID: <YN0lzsMfCWli9Qp+@localhost>
References: <bee03303d999225ecb3bfa5be8576b2f4c6edbe6.1623093259.git.josh@joshtriplett.org>
 <YNSVUy/DTWdhzuci@mit.edu>
 <YN0QxMh7ymC8obre@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YN0QxMh7ymC8obre@mit.edu>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jun 30, 2021 at 08:48:04PM -0400, Theodore Ts'o wrote:
> On Thu, Jun 24, 2021 at 10:23:15AM -0400, Theodore Ts'o wrote:
> > On Mon, Jun 07, 2021 at 12:15:08PM -0700, Josh Triplett wrote:
> > > Two different places checked for attempts to resize a filesystem with
> > > the bigalloc feature. Move the check into ext4_resize_begin, which both
> > > places already call.
> > > 
> > > Signed-off-by: Josh Triplett <josh@joshtriplett.org>
> > 
> > Applied, thanks.
> 
> I'm going to have to revert this change, since it breaks online
> resizing for bigalloc file system.  The issue is that
> ext4_resize_begin() is called from *three* places: for
> EXT4_IOC_GROUP_ADD, EXT4_IOC_GROUP_EXTEND, and EXT4_IOC_RESIZE_FS.
> The first two ioctls are used for the "old-style" online resize, and
> bigalloc is not supported for those two ioctls.  However, it *is*
> supposed to work for EXT4_IOC_RESIZE_FS.
> 
> Unfortunately, this just caused some tests to be skipped (assuming
> that this was an old kernel that didn't support this feature) and I
> didn't notice it right away.

Ah, I see. I didn't realize that resizing bigalloc was possible with
EXT4_IOC_RESIZE_FS; I'd assumed (incorrectly) from the error message
that it wasn't.

This patch was *purely* a side story of the second patch. I'd discovered
that the kernel couldn't successfully resize a filesystem with
sparse_super2, and wanted to catch that in the kernel and return a clear
error, rather than partially resizing the filesystem. In the course of
making that change, I noticed the two copies of the error for the
bigalloc case and tried to consolidate them.

Sorry to have missed the third case here, and no problems with the
revert. I'm hoping that the second patch can be kept as-is, assuming
there's no support for resizing sparse_super2 by any code path?

- Josh Triplett
