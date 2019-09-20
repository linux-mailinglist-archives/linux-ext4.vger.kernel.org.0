Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85D31B990F
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Sep 2019 23:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730225AbfITVbU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 20 Sep 2019 17:31:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:39368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729725AbfITVbU (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 20 Sep 2019 17:31:20 -0400
Received: from ebiggers-linuxstation.mtv.corp.google.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBD1E2080F
        for <linux-ext4@vger.kernel.org>; Fri, 20 Sep 2019 21:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569015080;
        bh=hzI7lHmFftZT81SfGRVw/xfESBQlg7ytOYS4xeDgdAQ=;
        h=From:To:Subject:Date:From;
        b=UQJSh2p0m2v+0efZOAi7DT/Lq3oFXLIZCjKirAKOZhWE3H2/27UjRC/TxlFKkCq3K
         SMGAYQgUwJ2ckn+dWp5ntlMewg30OrMSgVTjoDo6MJ4+nQYYY1Gcd4hS9Wg74OB37W
         P4haQlMqnU6Jyp8dMQXwwSwWhmHXz5v6Mnv5iiNM=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-ext4@vger.kernel.org
Subject: [PATCH 0/6] e2fsprogs: feature doc updates
Date:   Fri, 20 Sep 2019 14:29:48 -0700
Message-Id: <20190920212954.205789-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Document the verity feature, and make some minor updates to the
documentation for the encrypt and casefold features.

Eric Biggers (6):
  ext4.5: move casefold feature to correct position
  ext4.5: document first kernel version to support casefold feature
  ext4.5: document the verity feature
  ext4.5: tweak the documentation for the encrypt feature
  tune2fs.8: document the verity feature
  tune2fs.8: tweak the documentation for the encrypt feature

 misc/ext4.5.in    | 38 +++++++++++++++++++++++++++-----------
 misc/tune2fs.8.in |  7 ++++++-
 2 files changed, 33 insertions(+), 12 deletions(-)

-- 
2.23.0.351.gc4317032e6-goog

