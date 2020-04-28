Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98EEC1BC596
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Apr 2020 18:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbgD1Qps (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 28 Apr 2020 12:45:48 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:32708 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727957AbgD1Qps (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 28 Apr 2020 12:45:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588092347;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=1Auv4Q677TgaO/Jjufmlb746o6b6allGcG6kOFGCEuQ=;
        b=h0FExrUFCPDwcO2dGm+pGQStNO3Vc1j/fu0vOJEI+B6ak4mtzZgm1CYzvonlpiJ25LkH7e
        cHhXUPcZ93QI6V610wJFTUmgpdAguKW8Cyw8sC+61PrEm2fVohzUbOyOa25zxh7fZ90fTw
        +747i/J/21Q60DSp+AmPxwzmAPqPmXM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-68-a-l51wWiMvW1v3h1Suh_DA-1; Tue, 28 Apr 2020 12:45:45 -0400
X-MC-Unique: a-l51wWiMvW1v3h1Suh_DA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E7E4E1895A28;
        Tue, 28 Apr 2020 16:45:44 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.192.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 02D041000322;
        Tue, 28 Apr 2020 16:45:43 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     linux-ext4@vger.kernel.org
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk
Subject: [PATCH v2 00/17] ext4: new mount API conversion
Date:   Tue, 28 Apr 2020 18:45:19 +0200
Message-Id: <20200428164536.462-1-lczerner@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The following patch converts the ext4 to use the new mount API
(Documentation/filesystems/mount_api.txt).

The series can be applied on top of the current mainline tree and the wor=
k
is based on the patches from David Howells (thank you David). It was buil=
t
and tested with xfstests and custom test for ext4 mount options that was
sent over at fstests@vger.kernel.org for inclusion into xfstests.

I've tried to avoid big unrelated changes to the original ext4_fill_super=
()
and ext4_remount, though it could definitely use some cleanup. This can
be done after the conversion with a separate patch set as I don't want
to pollute the conversion with additional cleanup work.

NOTE:
There seems to be a regression somewhere in the new mount api as running
generic/085 in the loop locks up the machine. I was not able to track
the cause of it, but it seems to be outside of ext4. Dave is already
looking into it.

Changes:
v2: rebased to current kernel

-Lukas

