Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC4192D2B4D
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Dec 2020 13:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbgLHMoQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 8 Dec 2020 07:44:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27815 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725881AbgLHMoP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 8 Dec 2020 07:44:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607431369;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N3Fv48PR5PgtwxVDx9MCmEzlMi/IfF+DN5HL/YTVWA8=;
        b=PpQi3WzsEZJ6sV3j/BeBWnWtCnmZ0emVkk1JnaXQxj/+5vyrUZgnQueXuG/Z6czhFOks5x
        CL07JMY8ww8qTrSUFLaJKqU3DLPMaWUtu4CTX1t23kcaSalZu0DyDx235HrHyeX84hu2r9
        dTWbwzJf3qtGXwx2/4wfhdtUbOlQKBc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-173-cFA5FdiPOLSjrMEYhWuiaA-1; Tue, 08 Dec 2020 07:42:47 -0500
X-MC-Unique: cFA5FdiPOLSjrMEYhWuiaA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 44581192CC40;
        Tue,  8 Dec 2020 12:42:46 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-116-67.rdu2.redhat.com [10.10.116.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 31C485D9F4;
        Tue,  8 Dec 2020 12:42:44 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <87zh2p5d77.fsf@collabora.com>
References: <87zh2p5d77.fsf@collabora.com> <20201208003117.342047-1-krisman@collabora.com> <20201208003117.342047-6-krisman@collabora.com> <20201208005110.GA106255@magnolia>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     dhowells@redhat.com, "Darrick J. Wong" <darrick.wong@oracle.com>,
        viro@zeniv.linux.org.uk, tytso@mit.edu, khazhy@google.com,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH 5/8] vfs: Include origin of the SB error notification
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <952228.1607431363.1@warthog.procyon.org.uk>
Date:   Tue, 08 Dec 2020 12:42:43 +0000
Message-ID: <952229.1607431363@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Gabriel Krisman Bertazi <krisman@collabora.com> wrote:

> Since the structure is defined in the patch immediately before, I
> thought it would be ok to split the patch to preserve authorship of the
> different parts.

Think git bisect.

David

