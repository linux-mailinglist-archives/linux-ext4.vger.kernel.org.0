Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 628923E96DF
	for <lists+linux-ext4@lfdr.de>; Wed, 11 Aug 2021 19:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbhHKRd3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 11 Aug 2021 13:33:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38544 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231193AbhHKRd1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 11 Aug 2021 13:33:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628703182;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H+Z2OvOdDNew4xnvjARNlxn0P/ZlbmpJBQxfKOpupBk=;
        b=D0DlRk+dLoPTxtbVK0m0++/qdpr61QRKCWvUMG7o0CageM6dZkMCzdKNODXfB+xT6hNH0f
        jG6JZ2dNaflAbJ/3eOGjG9G2FocR7sSEgGZ4iL2Gq1cFH9TIfLacIhFObzzmOIyyrAVFKt
        kpNwg/CAOgwohh1J49YboKXtiNM2krI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-138-LwzFJ29XNFqc2KPXMdeQ5Q-1; Wed, 11 Aug 2021 13:33:01 -0400
X-MC-Unique: LwzFJ29XNFqc2KPXMdeQ5Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8FDC7802947;
        Wed, 11 Aug 2021 17:33:00 +0000 (UTC)
Received: from work (unknown [10.40.192.96])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9FD6819D9F;
        Wed, 11 Aug 2021 17:32:59 +0000 (UTC)
Date:   Wed, 11 Aug 2021 19:32:55 +0200
From:   Lukas Czerner <lczerner@redhat.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH 7/7] mkquota: Fix potental NULL pointer dereference
Message-ID: <20210811173255.4efoabz73vj4wz2y@work>
References: <20210806095820.83731-1-lczerner@redhat.com>
 <20210806095820.83731-7-lczerner@redhat.com>
 <YRKmIDH8XWBwGXAT@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YRKmIDH8XWBwGXAT@mit.edu>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Aug 10, 2021 at 12:15:28PM -0400, Theodore Ts'o wrote:
> On Fri, Aug 06, 2021 at 11:58:20AM +0200, Lukas Czerner wrote:
> > get_dq() function can fail when the memory allocation fails and so we
> > could end up dereferencing NULL pointer. Fix it.
> > 
> > Also, we should really return -ENOMEM instead of -1, or even 0 from
> > various functions in quotaio_tree.c when memory allocation fails.
> > Fix it as well.
> 
> The quota*.c files were taking from the quota_tools package, and are
> currently using the converion of setting errno and returning -1.  I
> don't think an incomplete conversion to the kernel error return
> convention is the way to go.  My long term plan for the quota
> functions in libsupport is to convert them to use the comerr_t error
> return convention, remove all of the printf functions from the
> functions, so they can be properly moved into libext2fs library as a
> first class supported library functions, and so that the high-level
> ext2fs functions would update the quota files --- so that programs
> like fuse2fs would properly update the quota records.
> 
> So I'm going to drop the error handling changes from this patch before
> applying it.

Understood, thanks!

-Lukas

> 
> Cheers,
> 
> 					- Ted
> 

