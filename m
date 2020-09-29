Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 283BF27D155
	for <lists+linux-ext4@lfdr.de>; Tue, 29 Sep 2020 16:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730784AbgI2OhV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 29 Sep 2020 10:37:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31602 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730131AbgI2OhV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 29 Sep 2020 10:37:21 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601390240;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=fKae7lwlthP7cllRLw7DA0kwji6Lg5GP5n+WM3InQe4=;
        b=CAV031F2coi5N1nXJzETk9AZ1qMQTu8a/unnZo2CNaDs6EeHauA6x2TUurfsxRM4hpyNKj
        22wgHl4kO8U8AP/wf1Gr3/hJP2Oto5uQxdJC58zvyWcVkA0AvO1nXQn7nVHnSO7yHRsHbL
        5gy7Lz58k/0DTeuqAPrJfrLWOz0EwNk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-539-YHu7V5cgOpyuTfhtV5o6Fw-1; Tue, 29 Sep 2020 10:37:18 -0400
X-MC-Unique: YHu7V5cgOpyuTfhtV5o6Fw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2C2A61019625
        for <linux-ext4@vger.kernel.org>; Tue, 29 Sep 2020 14:37:17 +0000 (UTC)
Received: from work (unknown [10.40.194.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9C4951002C0A
        for <linux-ext4@vger.kernel.org>; Tue, 29 Sep 2020 14:37:16 +0000 (UTC)
Date:   Tue, 29 Sep 2020 16:37:13 +0200
From:   Lukas Czerner <lczerner@redhat.com>
To:     linux-ext4@vger.kernel.org
Subject: State of dump utility
Message-ID: <20200929143713.ttu2vvhq22ulslwf@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

lately we've had couple of bugs against dump utility and a after a quick
look at the code I realized that it is very much outdated at least on
the extN side of things and would need some work and attention to make it
work reliably with modern ext4 features.

However the code has been neglected for a while and talking to the
maintainer he is pretty much done with it. At this point I am ready to
pull the plug on dump/restore in Fedora, but before I do I was wondering
whether there is any interest in moving dump/restore, or part of it, into
e2fsprogs ?

I have not looked at the code close enought to say whether it's worth it
or whether it would be better to write something from scratch. There is
also a question about what to do with the tape code - that's not
something I have any interest in digging into.

In my eyes dump had a good run and I would be happy just dumping it, but
it is worth asking here on the list. Is there anyone interested in
maintaining dump/restore, or is there interest in or objections agains
merging it into e2fsprogs ?

Thanks!
-Lukas

