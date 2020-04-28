Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 661D71BC44E
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Apr 2020 17:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbgD1P7N (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 28 Apr 2020 11:59:13 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46508 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728257AbgD1P7M (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 28 Apr 2020 11:59:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588089552;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SOQivZ8Iy7uQX3Qa0rgHzhMwES698KC3pdWCJfc5oTY=;
        b=K1/dei+zWuWXKnovmOzzGdO2FVDk4bG/igGinb0kak+ulknZNi2XGVA/UZ36LlwaUlQVmx
        P3x18QX/7Tl9zYSK7UWIctWJZaXx9kGcdLZSdMaPx7J2+wOGGD+R5AiYwL6pEJLJxpOxwx
        smG6Wh49FRbvzDWAKKhF1O0Qz0bFQw4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-KeD3fLDuM8Kll1OV1vf8xA-1; Tue, 28 Apr 2020 11:59:08 -0400
X-MC-Unique: KeD3fLDuM8Kll1OV1vf8xA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 565BD1005510;
        Tue, 28 Apr 2020 15:59:07 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-113-129.rdu2.redhat.com [10.10.113.129])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6C5755EDE0;
        Tue, 28 Apr 2020 15:59:03 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20200428152709.GG6733@magnolia>
References: <20200428152709.GG6733@magnolia> <1020558.1588082682@warthog.procyon.org.uk>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     dhowells@redhat.com, lczerner@redhat.com, viro@zeniv.linux.org.uk,
        linux-ext4@vger.kernel.org
Subject: Re: Notes on ext4 mount API parsing stuff
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1073042.1588089543.1@warthog.procyon.org.uk>
Date:   Tue, 28 Apr 2020 16:59:03 +0100
Message-ID: <1073043.1588089543@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Darrick J. Wong <darrick.wong@oracle.com> wrote:

> > Here are some notes on your ext4 mount API parsing stuff.
> 
> Er... is this a response to Lukas' patchset "ext4: new mount API
> conversion" from 6 Nov 2019?

Lukas says that's out of date.

David

