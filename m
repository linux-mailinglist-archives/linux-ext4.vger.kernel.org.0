Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D67A19A662
	for <lists+linux-ext4@lfdr.de>; Wed,  1 Apr 2020 09:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731889AbgDAHjM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 1 Apr 2020 03:39:12 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30348 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731870AbgDAHjM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 1 Apr 2020 03:39:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585726751;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=6DBCWg11wd9ugzi5HHdFRKDsIzVlbKlyVJ5RvLmNdUs=;
        b=KGfthJc2nklgIwhYvVAucbzgwwwtW/vIk1vWWjZSaBYClYs80BnShPJxQwxtyNb6gNxKE8
        XOI9R6c8Ed4Y0WP1odDsecwq5Heg5ymaRyUVIabOcD9fu+XucSgaban4jVjt/k/zQriWMW
        KrC0efFTSwlQS7/YmxI9N9zlwWlfjng=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-pZr1316LOJeYXx6wU0cW8A-1; Wed, 01 Apr 2020 03:39:10 -0400
X-MC-Unique: pZr1316LOJeYXx6wU0cW8A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1B5B5800D5B;
        Wed,  1 Apr 2020 07:39:09 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-114-243.ams2.redhat.com [10.36.114.243])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2537219C6A;
        Wed,  1 Apr 2020 07:39:07 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     tytso@mit.edu
cc:     dhowells@redhat.com, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org
Subject: Exporting ext4-specific information through fsinfo attributes
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2461553.1585726747.1@warthog.procyon.org.uk>
Date:   Wed, 01 Apr 2020 08:39:07 +0100
Message-ID: <2461554.1585726747@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Ted,

Whilst we were at Vault, I asked you if there was any live ext4 information
that it could be useful to export through fsinfo().  I've implemented a patch
that exports six superblock timestamps:

	FSINFO_ATTR_EXT4_TIMESTAMPS: 
		mkfs    : 2016-02-26 00:37:03
		mount   : 2020-03-31 21:57:30
		write   : 2020-03-31 21:57:28
		fsck    : 2018-12-17 23:32:45
		1st-err : -
		last-err: -

but is there anything else that could be of interest?

Thanks,
David

