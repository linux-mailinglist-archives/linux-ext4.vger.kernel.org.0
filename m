Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C607C2CA97E
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Dec 2020 18:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387865AbgLARWb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 1 Dec 2020 12:22:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36514 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729325AbgLARWb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 1 Dec 2020 12:22:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606843265;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lMe49E1mnnmlHTInfsQf5rgPXjI/ES+UysXV6vFipss=;
        b=KSzi+DkntUm7spw1oCvMkYvY1/zolC8uW4c5JGCE5k7Mez03xI0Te8JhgmQnJ/VphHGhg3
        wbPwZqbEfMZH9izLHodjp0pbzS8lcQwmYuX7BN1BIoSkl3OO2VyEf2QPtkqurMc1EkgNtz
        2SI4uFqHReuZUQfiEs0xD63nA4LYDGc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-393-16vq1k01M-unSC-WCvPP0Q-1; Tue, 01 Dec 2020 12:21:03 -0500
X-MC-Unique: 16vq1k01M-unSC-WCvPP0Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 06C959A232;
        Tue,  1 Dec 2020 17:21:02 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-159.rdu2.redhat.com [10.10.112.159])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1C6D660C0F;
        Tue,  1 Dec 2020 17:20:56 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <05a0f4fd-7f62-8fbc-378d-886ccd5b3f11@redhat.com>
References: <05a0f4fd-7f62-8fbc-378d-886ccd5b3f11@redhat.com> <e388f379-cd11-a5d2-db82-aa1aa518a582@redhat.com>
To:     Eric Sandeen <sandeen@redhat.com>
Cc:     dhowells@redhat.com, torvalds@linux-foundation.org,
        Miklos Szeredi <mszeredi@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-fsdevel@vger.kernel.org,
        linux-man@vger.kernel.org, linux-kernel@vger.kernel.org,
        xfs <linux-xfs@vger.kernel.org>, linux-ext4@vger.kernel.org,
        Xiaoli Feng <xifeng@redhat.com>
Subject: Re: [PATCH 2/2] statx: move STATX_ATTR_DAX attribute handling to filesystems
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <286507.1606843256.1@warthog.procyon.org.uk>
Date:   Tue, 01 Dec 2020 17:20:56 +0000
Message-ID: <286508.1606843256@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Eric Sandeen <sandeen@redhat.com> wrote:

> -	if (IS_DAX(inode))
> -		stat->attributes |= STATX_ATTR_DAX;
> -

This could probably be left in and not distributed amongst the filesytems
provided that any filesystem that might turn it on sets the bit in the
attributes_mask.

I'm presuming that the core doesn't turn it on without the filesystem buying
in.

David

