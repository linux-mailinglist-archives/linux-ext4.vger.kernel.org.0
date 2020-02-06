Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA680154BF8
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Feb 2020 20:20:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbgBFTUV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 6 Feb 2020 14:20:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41885 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728085AbgBFTUU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 6 Feb 2020 14:20:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581016819;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jSjZIFf8bov0cUpKlluvDppg7BypaTcf6SuSYJRnXGQ=;
        b=b2xFuC7dV8vcuCNORDC167Kpo1ntOnb0EPpkE3s5xef3K6T5NNOoSclQ951P7sL0c8zVLL
        XIIlVIPQXmXQsIVK6pnf42Cc1tPiB0xyl8iBxt8pqhF3hc11bW4m6F77fX8jTvf3n2EOB5
        Fmy7oE3ZYsj0SxNToEbxhqiCJz0dguI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-216-_zh_Ai_XN_Wl6H21OtAeWA-1; Thu, 06 Feb 2020 14:20:13 -0500
X-MC-Unique: _zh_Ai_XN_Wl6H21OtAeWA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ABB9F18B9FC1;
        Thu,  6 Feb 2020 19:20:12 +0000 (UTC)
Received: from work (ovpn-205-99.brq.redhat.com [10.40.205.99])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C283019C7F;
        Thu,  6 Feb 2020 19:20:11 +0000 (UTC)
Date:   Thu, 6 Feb 2020 20:20:07 +0100
From:   Lukas Czerner <lczerner@redhat.com>
To:     Eric Sandeen <sandeen@sandeen.net>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu
Subject: Re: [PATCH] tst_libext2fs: Avoid multiple definition of global
 variables
Message-ID: <20200206192007.l7fv4ljxhhmvdmvx@work>
References: <20200130132122.21150-1-lczerner@redhat.com>
 <acd954b1-b92f-8cd7-0ff7-8d38f449df2f@sandeen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acd954b1-b92f-8cd7-0ff7-8d38f449df2f@sandeen.net>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Feb 06, 2020 at 11:52:17AM -0600, Eric Sandeen wrote:
> On 1/30/20 7:21 AM, Lukas Czerner wrote:
> > gcc version 10 changed the default from -fcommon to -fno-common and as a
> > result e2fsprogs unit tests fail because tst_libext2fs.c end up with a
> > build error.
> > 
> > This is because it defines two global variables debug_prog_name and
> > extra_cmds that are already defined in debugfs/debugfs.c. With -fcommon
> > linker was able to resolve those into the same object, however with
> > -fno-common it's no longer able to do it and we end up with
> > multiple definition errors.
> > 
> > Fix the problem by creating an extern declaration of said variables in
> > debugfs.h and just setting them in tst_libext2fs.c without additional
> > declaration.
> > 
> > Signed-off-by: Lukas Czerner <lczerner@redhat.com>
> 
> This looks fine to me.
> 
> Reviewed-by: Eric Sandeen <sandeen@redhat.com>
> 
> Is there any need to fix the one in lib/ext2fs/extent.c ?  It's only there
> under #ifdef DEBUG though.

Yeah, but if we ever want to use DEBUG macro it would fail with
-fno-common. Uff, I guess I have to fix this one as well.

Thanks Eric,
-Lukas

> 
> Thanks,
> -Eric
> 

