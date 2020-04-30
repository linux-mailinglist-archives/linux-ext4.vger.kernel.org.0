Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B77A01C054E
	for <lists+linux-ext4@lfdr.de>; Thu, 30 Apr 2020 20:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgD3Sxe (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 30 Apr 2020 14:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbgD3Sxe (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 30 Apr 2020 14:53:34 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 164FCC035494
        for <linux-ext4@vger.kernel.org>; Thu, 30 Apr 2020 11:53:33 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id c63so6883713qke.2
        for <linux-ext4@vger.kernel.org>; Thu, 30 Apr 2020 11:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i7rYYR6YnSVPsDLbao83y3nhtY+/BqGKX58oVdteZDE=;
        b=HCYVQM71RzYJ6SFfX2saPAWmTF3C/2Tz/XTKsA9YkHVcptuxil0LxsOWclZ785ugWY
         ik1YRGlHfeLo6v9IvlLV3p97AHlj9hp3GnBSQ3pcgeVK4rnflZpMi9GIgjedZX7uOQDV
         eJlkBRnyYI3GIWxdbagjzkBGyxr+F38svyHnzuKlKp3PA5EWkOLrGexwPByeJGyxxlBw
         UtGnUokYylhe6S9o+qcpdOgExgdwp/wj9ZSFdrBp6nqOodpFHMkgV01aVGna/l1vOiKE
         6AG0+KZx8++yUr9jif8v64nr6q7xS7capmgkbA2DA50jwgpHfcbyoKdHKOjFrr1tQF8a
         Jtaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i7rYYR6YnSVPsDLbao83y3nhtY+/BqGKX58oVdteZDE=;
        b=oiJ2dQy1JN9n16ExEIs9dEfoHsglnx1eOWxnKK7H8+Vnqn7nEBIAUDQdVZdyQw84Sm
         hTH62pwth/R2LLAvpNe8Z/x4zkxiVRN7+zO57Cnq2iTsevE6nYHAc6w48go17WVKVZmm
         0NL6VQZ+c+rWORyB/T0S5cv0Po0fgE96ZYQ6ps7+d2iGHXR+899cIT0bT0QiPzfHddTo
         ucWjJML9jQWqvsa3mhFSGd1LUP/5SkKO7RIPC2Iha3DgJWsQ+OPDAO4QBq5Pz/amVv+K
         PKqXuLy4xKnJlMjDK47hWkhjT1bagmA6UOzdXQ5IBXgC8c47uFT3IbIw97V9xl4wtf6C
         Gjrw==
X-Gm-Message-State: AGi0PuYElm5JoIV61dhrLcWYKa7ymljRfbLNhQqG17s7SPYZIG9Iymol
        M2IcA58yU4FpAKd/PUeCdMgyaj+E
X-Google-Smtp-Source: APiQypJ3um5reaiCBzw+sb/SRlSjATBQQYZaeaM6V5HBGhSkAPLKPN1Zh4SZdKqBBlBKdlJYFsQ4rQ==
X-Received: by 2002:a37:91c6:: with SMTP id t189mr5017760qkd.280.1588272811883;
        Thu, 30 Apr 2020 11:53:31 -0700 (PDT)
Received: from localhost.localdomain (c-73-60-226-25.hsd1.nh.comcast.net. [73.60.226.25])
        by smtp.gmail.com with ESMTPSA id u5sm695815qkm.116.2020.04.30.11.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 11:53:30 -0700 (PDT)
From:   Eric Whitney <enwlinux@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Eric Whitney <enwlinux@gmail.com>
Subject: [PATCH 0/4] ext4: clean up ext4_ext_handle_unwritten_extents()
Date:   Thu, 30 Apr 2020 14:53:16 -0400
Message-Id: <20200430185320.23001-1-enwlinux@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Changes made to ext4 over time have resulted in some cruft accumulating
in ext4_ext_handle_unwritten_extents().  This patch series removes
some dead and some redundant code, simplifies and corrects some error
handling, and adds explicit error logging when an unexpected internal
error or file system corruption may have occurred.

Eric Whitney (4):
  ext4: remove dead GET_BLOCKS_ZERO code
  ext4: remove redundant GET_BLOCKS_CONVERT code
  ext4: clean up GET_BLOCKS_PRE_IO error handling
  ext4: clean up ext4_ext_convert_to_initialized() error handling

 fs/ext4/extents.c | 81 ++++++++++++++++++++++++++---------------------
 1 file changed, 45 insertions(+), 36 deletions(-)

-- 
2.20.1

