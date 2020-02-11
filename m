Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4143D159A71
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Feb 2020 21:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731079AbgBKUWW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 11 Feb 2020 15:22:22 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44343 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731076AbgBKUWW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 11 Feb 2020 15:22:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581452540;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5bD3yovag2fIgarV4jsr+j0HIPraUUFbfuVz3Lcns4Q=;
        b=E6h1GvALIMk+6N0fN809qn/LNerEWauu/ZE97eF3pAgpB80Q+Ug7DrLH3w1dLtQjF7O4Vd
        vy0mMzr59Qq2c3miJScrmLjeM8mrmyQuHmGCGIluI7E2vvEeWA3F6GunhgNFj50Rso/CBq
        FaMX/bqlkOTI6jl+TEIEQxcTKwswlFw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-M4rYFIEIMFODbqhK1iaeew-1; Tue, 11 Feb 2020 15:22:16 -0500
X-MC-Unique: M4rYFIEIMFODbqhK1iaeew-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B31E36125A;
        Tue, 11 Feb 2020 20:22:15 +0000 (UTC)
Received: from [IPv6:::1] (ovpn04.gateway.prod.ext.phx2.redhat.com [10.5.9.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B4C1110246E3;
        Tue, 11 Feb 2020 20:22:14 +0000 (UTC)
Subject: Re: [PATCH v2] tst_libext2fs: Avoid multiple definition of global
 variables
To:     Lukas Czerner <lczerner@redhat.com>, linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu
References: <20200130132122.21150-1-lczerner@redhat.com>
 <20200210152459.19903-1-lczerner@redhat.com>
From:   Eric Sandeen <sandeen@redhat.com>
Message-ID: <f75ab2d5-9c59-a190-6fa5-c5f0e645da9c@redhat.com>
Date:   Tue, 11 Feb 2020 14:22:13 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200210152459.19903-1-lczerner@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2/10/20 9:24 AM, Lukas Czerner wrote:
> gcc version 10 changed the default from -fcommon to -fno-common and as a
> result e2fsprogs make check tests fail because tst_libext2fs.c end up
> with a build error.
> 
> This is because it defines two global variables debug_prog_name and
> extra_cmds that are already defined in debugfs/debugfs.c. With -fcommon
> linker was able to resolve those into the same object, however with
> -fno-common it's no longer able to do it and we end up with multiple
> definition errors.
> 
> Fix the problem by using SKIP_GLOBDEFS macro to skip the variables
> definition in debugfs.c. Note that debug_prog_name is also defined in
> lib/ext2fs/extent.c when DEBUG macro is used, but this does not work even
> with older gcc versions and is never used regardless so I am not going to
> bother with it.
> 
> Signed-off-by: Lukas Czerner <lczerner@redhat.com>
> ---
> v2: Previous fix wasn't really working properly

What was not working properly?

It seemed reasonable to me.  The new mechanism looks like it would work,
but the first patch seemed more obvious, so I'd like to know what the problem
was.

Thanks,
-Eric

