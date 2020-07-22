Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31FA1229411
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Jul 2020 10:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730813AbgGVIxP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 22 Jul 2020 04:53:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44279 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726892AbgGVIxO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 22 Jul 2020 04:53:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595407993;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=njgR9t8BrIwFryA3CMw6nKzzZ1JJJJbharNMOP2OpHQ=;
        b=HOVByX27VUp2wyKDsAXCQc3Ab7uV8Q3iu5yhI2SyQ1OZLrQtIVXRmFyrevnrask+KhvkIE
        hkj1E4Afvy8zgOFssJByr/A56mpbz+SUTtlCUdNWzmvBgyJBguciFplgtCvv7TD79J4fYC
        KoNvw/0JnIDDn9H3C+RUjCrc4MyPqwk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-zJDZx9dxNC6ScYqIhCay1w-1; Wed, 22 Jul 2020 04:53:09 -0400
X-MC-Unique: zJDZx9dxNC6ScYqIhCay1w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7E25B19253C0;
        Wed, 22 Jul 2020 08:53:08 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-32.rdu2.redhat.com [10.10.112.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2F5645D9D7;
        Wed, 22 Jul 2020 08:53:07 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20200721154202.GD848607@magnolia>
References: <20200721154202.GD848607@magnolia> <20200401151837.GB56931@magnolia> <2461554.1585726747@warthog.procyon.org.uk> <2504712.1587485842@warthog.procyon.org.uk>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     dhowells@redhat.com, Eric Biggers <ebiggers@kernel.org>,
        tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
Subject: Re: Exporting ext4-specific information through fsinfo attributes
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <701162.1595407986.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Wed, 22 Jul 2020 09:53:06 +0100
Message-ID: <701163.1595407986@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Darrick J. Wong <darrick.wong@oracle.com> wrote:

> Where are these FSINFO_FEAT* constants defined, and where are they
> documented?
> =

> This generally looks ok to me, but I would like to see documentation
> first.

Have a look at this branch:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log=
/?h=3Dfsinfo-core

Patch "fsinfo: Provide a bitmap of supported features"

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/com=
mit/?h=3Dfsinfo-core&id=3D9d7651e966331f18c7bfe053237b3627585c3e79

Documentation:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/com=
mit/?h=3Dfsinfo-core&id=3D6bb357c42c96c2a5d72ff02d109ce49bd0c455ab

David

