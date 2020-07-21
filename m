Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B722E227B98
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Jul 2020 11:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbgGUJUl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 21 Jul 2020 05:20:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54199 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726928AbgGUJUl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 21 Jul 2020 05:20:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595323240;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sv/ghfSihcC/k9xUblGJxCJ7j0PN54embSTEUAu3/S0=;
        b=HqAN4IVTxZt9P2v9MVAuwM3pxy4WYOseuTo1iWnVhNiQdQKakwZeqEzdzcqIzFb2Ge2PBT
        hxxvDjMTJrO3uXEAQFsP77E6YjI2JVzOG+az/V15rTiJnq1gxTQmhWaxgTS8yN/oKVGC6D
        t7tC5dD6Eb5xaIuqVa2CpcHeCIN9aIA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-127-4NRH_XbaNTiDiAr1ERaFwg-1; Tue, 21 Jul 2020 05:20:38 -0400
X-MC-Unique: 4NRH_XbaNTiDiAr1ERaFwg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 061C619067E0;
        Tue, 21 Jul 2020 09:20:37 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-32.rdu2.redhat.com [10.10.112.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D6A555D9CA;
        Tue, 21 Jul 2020 09:20:35 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20200422161242.GD6733@magnolia>
References: <20200422161242.GD6733@magnolia> <20200401151837.GB56931@magnolia> <2461554.1585726747@warthog.procyon.org.uk> <2504712.1587485842@warthog.procyon.org.uk> <BFC9114B-7D3D-4B8F-A8BB-75C2770EE36D@dilger.ca>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     dhowells@redhat.com, Andreas Dilger <adilger@dilger.ca>,
        Eric Biggers <ebiggers@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: Exporting ext4-specific information through fsinfo attributes
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <533171.1595323235.1@warthog.procyon.org.uk>
Date:   Tue, 21 Jul 2020 10:20:35 +0100
Message-ID: <533172.1595323235@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Darrick J. Wong <darrick.wong@oracle.com> wrote:

> The other properties look fine (in principle) to me though. :)

Can I put that down as a reviewed-by?

Thanks,
David

