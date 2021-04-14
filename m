Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D40CA35F04C
	for <lists+linux-ext4@lfdr.de>; Wed, 14 Apr 2021 11:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232203AbhDNJBS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 14 Apr 2021 05:01:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58608 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244803AbhDNJAO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 14 Apr 2021 05:00:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618390724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=cUcglsxOYfuHKKMr/TtJ0G52JdWYf/U06GoeD6nm1EM=;
        b=gMywellq/DPUtCspEyyvogEEOdng6qIAy5OEbj/YkEHpyTb4cgMhYwceNJgE/W8G7r9Yyq
        2e6lH6zc4pe7oMvntHxrpDW7/ozd6I7n0We3TcCtGoR4GlIvb5kV8TJPdPs9GoyPlO6vIz
        0LZaXC1lPmSxbXrqQpu7AQfvcK0dNA4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-tfVLFSjyP_Ksiv20bRDWxQ-1; Wed, 14 Apr 2021 04:58:39 -0400
X-MC-Unique: tfVLFSjyP_Ksiv20bRDWxQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4D39E79EC0;
        Wed, 14 Apr 2021 08:58:37 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-112-67.rdu2.redhat.com [10.10.112.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AC06262A22;
        Wed, 14 Apr 2021 08:58:34 +0000 (UTC)
From:   Nico Pache <npache@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     brendanhiggins@google.com, gregkh@linuxfoundation.org,
        linux-ext4@vger.kernel.org, netdev@vger.kernel.org,
        rafael@kernel.org, npache@redhat.com,
        linux-m68k@lists.linux-m68k.org, geert@linux-m68k.org,
        tytso@mit.edu, mathew.j.martineau@linux.intel.com,
        davem@davemloft.net, broonie@kernel.org, davidgow@google.com,
        skhan@linuxfoundation.org, mptcp@lists.linux.dev
Subject: [PATCH v2 0/6] kunit: Fix formatting of KUNIT tests to meet the standard
Date:   Wed, 14 Apr 2021 04:58:03 -0400
Message-Id: <cover.1618388989.git.npache@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

There are few instances of KUNIT tests that are not properly defined.
This commit focuses on correcting these issues to match the standard
defined in the Documentation.

Issues Fixed:
 - tests should end in KUNIT_TEST, some fixes have been applied to
   correct issues were KUNIT_TESTS is used or KUNIT is not mentioned.
 - Tests should default to KUNIT_ALL_TESTS
 - Tests configs tristate should have if !KUNIT_ALL_TESTS

No functional changes other than CONFIG name changes

Changes since v2:
 - Split patch 1 by subcomponents
 - fix issues where config was *KUNIT_TEST_TEST
 - properly threaded/chained messages

Nico Pache (6):
  kunit: ASoC: topology: adhear to KUNIT formatting standard
  kunit: software node: adhear to KUNIT formatting standard
  kunit: ext4: adhear to KUNIT formatting standard
  kunit: lib: adhear to KUNIT formatting standard
  kunit: mptcp: adhear to KUNIT formatting standard
  m68k: update configs to match the proper KUNIT syntax

 arch/m68k/configs/amiga_defconfig    |  6 +++---
 arch/m68k/configs/apollo_defconfig   |  6 +++---
 arch/m68k/configs/atari_defconfig    |  6 +++---
 arch/m68k/configs/bvme6000_defconfig |  6 +++---
 arch/m68k/configs/hp300_defconfig    |  6 +++---
 arch/m68k/configs/mac_defconfig      |  6 +++---
 arch/m68k/configs/multi_defconfig    |  6 +++---
 arch/m68k/configs/mvme147_defconfig  |  6 +++---
 arch/m68k/configs/mvme16x_defconfig  |  6 +++---
 arch/m68k/configs/q40_defconfig      |  6 +++---
 arch/m68k/configs/sun3_defconfig     |  6 +++---
 arch/m68k/configs/sun3x_defconfig    |  6 +++---
 drivers/base/test/Kconfig            |  2 +-
 drivers/base/test/Makefile           |  2 +-
 fs/ext4/.kunitconfig                 |  2 +-
 fs/ext4/Kconfig                      |  2 +-
 fs/ext4/Makefile                     |  2 +-
 lib/Kconfig.debug                    | 21 +++++++++++++--------
 lib/Makefile                         |  6 +++---
 net/mptcp/Kconfig                    |  2 +-
 net/mptcp/Makefile                   |  2 +-
 net/mptcp/crypto.c                   |  2 +-
 net/mptcp/token.c                    |  2 +-
 sound/soc/Kconfig                    |  2 +-
 sound/soc/Makefile                   |  4 ++--
 25 files changed, 64 insertions(+), 59 deletions(-)

-- 
2.30.2

