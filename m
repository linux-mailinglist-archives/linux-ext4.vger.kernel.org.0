Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD1CD21A726
	for <lists+linux-ext4@lfdr.de>; Thu,  9 Jul 2020 20:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726782AbgGIShg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 9 Jul 2020 14:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbgGIShg (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 9 Jul 2020 14:37:36 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44AF9C08C5DC
        for <linux-ext4@vger.kernel.org>; Thu,  9 Jul 2020 11:37:36 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id i203so3878885yba.9
        for <linux-ext4@vger.kernel.org>; Thu, 09 Jul 2020 11:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=jX3Dl5MD86mdHXIoT9uhkh4rwhA/qfoAVP4P5zty3kA=;
        b=WgEsD0UEzsJV03enG5aRoI3j2aW3S9lLqUsDOuWaj4TZga8a4G9C3ZYMk2ZgY7xzLg
         G2MrbeOBrB9vhTy92N4KyJn7e9e5Nj+p2Xi0vH5IZGNkSCG8eQIC15yljwa3qJ58661z
         dBVQ4RBz4NNO7Q7Z/Hwy7u8CEBkNvhGz/7UEq++bMx1gNtNkfeFQEL9Os+rbQ3Z2CM3p
         62MT39WSuxfx2B1zGTa4dK8toluusmAHqjdXjq4XPY2YbWLRX0jlqRn8Zjq7Wxr9suh9
         40Dyx8vcy+facuoqlJGacyO6WW8kqNzLD6ZdNsXSlZsQybT8xPmwjM6ix3a2vjaXT1Jw
         jrIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=jX3Dl5MD86mdHXIoT9uhkh4rwhA/qfoAVP4P5zty3kA=;
        b=A9Sn6t6aGyCFIvFOzAZmJdM20QEtYL04+O0PIzRKTF3+1OLj9Y/O89jHZDHJMoRuTQ
         KBn+DzJW5IId+O06zfnIF6S24MlH2caexnrQG3JVBYOtbIyuorTc9zx0gKziDkgj8LUg
         0VU66SCmAQeXtNPbqsvpELF6e/vZ4c8vFSbDf0B84Nd1dWAAp1IjFSG4hMAsnVMlVbnm
         O66Wd3PdrpkzuG/0yrV4iLzf9ZU8t6jFuDoTxg/CnXUlHE/PR/v2kWdhXRxRdjRqRvJ8
         R5tr0yNnWiLThAUuZQP8lBdjCFMbLt3Vie3IoZQVhCLX60o4HMLg3ZUK++nvW0UQrzva
         CAZw==
X-Gm-Message-State: AOAM53195SsTeLUW7kcDC8kRTJwFMafWO/inM0hXtP+1qcRjOGY1QBTw
        juo0CODm/R3PiZSfKjtW3DKnNAY93UU=
X-Google-Smtp-Source: ABdhPJwHvBa/Xhxv6BP99lYbeqO814swZ9afJP0a3xYjlceyai+zBMgK4+f/oQEsWkzp73BD/2ySbzyOj+M=
X-Received: by 2002:a25:d046:: with SMTP id h67mr12549102ybg.458.1594319855427;
 Thu, 09 Jul 2020 11:37:35 -0700 (PDT)
Date:   Thu,  9 Jul 2020 18:37:01 +0000
Message-Id: <20200709183701.2564213-1-satyat@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
Subject: [xfstests-bld PATCH] test-appliance: exclude generic/587 from the
 encrypt tests
From:   Satya Tangirala <satyat@google.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        Satya Tangirala <satyat@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The encryption feature doesn't play well with quota, and generic/587
tests quota functionality.

Signed-off-by: Satya Tangirala <satyat@google.com>
---
 .../test-appliance/files/root/fs/ext4/cfg/encrypt.exclude        | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kvm-xfstests/test-appliance/files/root/fs/ext4/cfg/encrypt.exclude b/kvm-xfstests/test-appliance/files/root/fs/ext4/cfg/encrypt.exclude
index 47c26e7..07111c2 100644
--- a/kvm-xfstests/test-appliance/files/root/fs/ext4/cfg/encrypt.exclude
+++ b/kvm-xfstests/test-appliance/files/root/fs/ext4/cfg/encrypt.exclude
@@ -24,6 +24,7 @@ generic/270
 generic/381
 generic/382
 generic/566
+generic/587
 
 # encryption doesn't play well with casefold (at least not yet)
 generic/556
-- 
2.27.0.383.g050319c2ae-goog

