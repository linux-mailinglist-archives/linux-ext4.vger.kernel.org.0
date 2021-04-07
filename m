Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE4635709B
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Apr 2021 17:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232537AbhDGPmR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 7 Apr 2021 11:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbhDGPmR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 7 Apr 2021 11:42:17 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 905FCC061756
        for <linux-ext4@vger.kernel.org>; Wed,  7 Apr 2021 08:42:07 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id q4so4571669vsm.0
        for <linux-ext4@vger.kernel.org>; Wed, 07 Apr 2021 08:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IAbQDTHRgSYMJJwwizM1ILsUjR36IU2VlRVsaAfRbYg=;
        b=iJuOutD4XmO7UDrOB/bx4GfzDyUpD15qXJxNq3GLR/FwAks5tb7x1yupJhmuYNZW0V
         H3sCuDaMIcN71YThbnlUqtxBC/qHMBuXj1wzrQRpHuOkJ8PfKyMCBdwmmM0CgSEDI8Cs
         iWypmCbVurPtdnnUpU+ejZWa3H8ugYr7VeCQmIIv4bs76KJyEfOyN5dMPZhTgwKriTKN
         cj44aalVzRetUKwBRrKuAOSSZ17zUikhxapWx1Q6dtst7OcerCq5nQShoJrb21ncarDx
         VUOE9XKASKJwWkbO2EsOUAbeJK4Vm9bD/F4JvMqUcg9tZ5Nqjmpyv7YIbRpuVFRyFklW
         PdyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IAbQDTHRgSYMJJwwizM1ILsUjR36IU2VlRVsaAfRbYg=;
        b=H4ZwqLQ8R6104cnpygfUrnjFLd+FZ6MSC0zyKQsHf6gi6NJTXq+lCVk0HlJ+Ww6nph
         lohCWtYJzQZD57JxRF9i+2dITphF0TlEV1yCRdIPqBqmuGkZAxZZcIcTW10JJXoLqV77
         jMKLR7p5/jKA+cH176v93L3bVN7P5I0NLjsqHZcbxeDWR6+lA3p+pvHaXPn3wo3LX/mh
         0wVhz+CYvRApj07NKyUpHW768uCA/RMXlVJtQNQMi3rjtW5EBOSBNpDEQNbUzE6FA4ch
         b//1quvJri3fErVqaySJ8BLkv7y4wHKlOYDi9xfO/FnYbfCg9wM9kXU32Q5Zf0U+Koz2
         nn2w==
X-Gm-Message-State: AOAM532fME7lBgVUyYb7882ukXNNlcTX3p0aCaeSpsATPr+eXJl6rR3a
        ULQRfhlFHMOPFnA8mdNaSaJfLnPvFgw=
X-Google-Smtp-Source: ABdhPJy38N7SDr1ReZu21vHboaZEHoiRELiDKW2LVCgoifkfleMT2rdEK3QzDmEfaU9EMf6wMuAiIQ==
X-Received: by 2002:a67:d59c:: with SMTP id m28mr2516926vsj.1.1617810126541;
        Wed, 07 Apr 2021 08:42:06 -0700 (PDT)
Received: from leah-cloudtop2.c.googlers.com.com (162.116.74.34.bc.googleusercontent.com. [34.74.116.162])
        by smtp.googlemail.com with ESMTPSA id 81sm1172630uaq.3.2021.04.07.08.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 08:42:06 -0700 (PDT)
From:   Leah Rumancik <leah.rumancik@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH v2 0/2] Filename wipeout patch series updates
Date:   Wed,  7 Apr 2021 15:42:00 +0000
Message-Id: <20210407154202.1527941-1-leah.rumancik@gmail.com>
X-Mailer: git-send-email 2.31.0.208.g409f899ff0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

[1/2] ext4: wipe filename upon file deletion:
- removed mount option for filename wipe, now filename wipe is
default behavior
- added wiping of file type at time of filename wipe

[2/2] ext4: add ioctl FS_IOC_CHKPT_JRNL:
- moved ioctl definition to include/uapi/linux/fs.h
- renamed ioctl FS_IOC_CHKPT_JRNL
- updated to require admin privileges to call ioctl
- updated ioctl to take _u64
- updated jbd2_journal_flush to take flags argument to allow
for discard flag
(kernel: JBD2_FLAG_DO_DISCARD / userspace: CHKPT_JRNL_DO_DISCARD)

Leah Rumancik (2):
  ext4: wipe filename upon file deletion
  ext4: add ioctl FS_IOC_CHKPT_JRNL

 fs/ext4/ext4.h          |   1 +
 fs/ext4/inode.c         |   4 +-
 fs/ext4/ioctl.c         |  34 ++++++++++++--
 fs/ext4/namei.c         |   4 ++
 fs/ext4/super.c         |   6 +--
 fs/jbd2/journal.c       | 100 +++++++++++++++++++++++++++++++++++++++-
 fs/ocfs2/alloc.c        |   2 +-
 fs/ocfs2/journal.c      |   8 ++--
 include/linux/jbd2.h    |   5 +-
 include/uapi/linux/fs.h |   4 ++
 10 files changed, 152 insertions(+), 16 deletions(-)

-- 
2.31.0.208.g409f899ff0-goog

