Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9445028437D
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Oct 2020 02:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbgJFAsw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 5 Oct 2020 20:48:52 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56622 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbgJFAsw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 5 Oct 2020 20:48:52 -0400
Received: from mail-qv1-f70.google.com ([209.85.219.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <mfo@canonical.com>)
        id 1kPb9u-0004US-C4
        for linux-ext4@vger.kernel.org; Tue, 06 Oct 2020 00:48:50 +0000
Received: by mail-qv1-f70.google.com with SMTP id w32so7118792qvw.8
        for <linux-ext4@vger.kernel.org>; Mon, 05 Oct 2020 17:48:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KL3RF0x6ptbcwHYMVL6UlKkC5BqgmC0cXv7kdsRP0mE=;
        b=rkoAQzNlg7NPASQ3pFXwkuyUKUFP3n1LDQkkeIDgkDLHHya1xZGxnOV2jwc87FDzDx
         jwbAHKN5KWKhX3bEekIWkQxaMB778IZhfZmQIAoX1rq74WBZzSnHXfETkv2CH70lWx/y
         n5+t4R3s7moeaka3tQCYJAQnvBntPAGuDnoNsVeu59Pc5GoB5B5pE6NkZzVZcMF1JfW/
         h4rt2OJpRAmklmgYMGLstNR0HR5EsShZm4maLFEHPT1NMcnuvPUaYWcVfdHGpBp65pWZ
         uvWlRFih6yCEMs/UhFRlKbDHofGpyEFC/01RghGp+a8DcwpwrWqdRkWXxvcCOodDEpMX
         pmKg==
X-Gm-Message-State: AOAM532gT2xCtF+NPwcvpu/m01yMBC2Hvug6UfShH+/tjMmlNO6ceXIV
        3VwApbUIugYeM0x8ZBFrE1Dd5A7nupCrV3U0bwv/Y+OcIld7bB3J6js8XZOD3DqL+Nl5+iFGaRV
        elLIX+kO1oEZlTZkQBKRkywqQxLJymOgbIIEEiqg=
X-Received: by 2002:a37:b603:: with SMTP id g3mr2892616qkf.475.1601945329237;
        Mon, 05 Oct 2020 17:48:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyxZkbhoqME9I7m2h7Z5byls3odgeUtI1a/cJQ0Y/+N6nWVm1gD7uSMKgLaIAUt06EJdMQH4g==
X-Received: by 2002:a37:b603:: with SMTP id g3mr2892603qkf.475.1601945328987;
        Mon, 05 Oct 2020 17:48:48 -0700 (PDT)
Received: from localhost.localdomain ([201.82.49.101])
        by smtp.gmail.com with ESMTPSA id l125sm1355322qke.23.2020.10.05.17.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 17:48:48 -0700 (PDT)
From:   Mauricio Faria de Oliveira <mfo@canonical.com>
To:     linux-ext4@vger.kernel.org, ocfs2-devel@oss.oracle.com
Cc:     Jan Kara <jack@suse.cz>, Andreas Dilger <adilger@dilger.ca>,
        dann frazier <dann.frazier@canonical.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
Subject: [PATCH v5 0/4] ext4/jbd2: data=journal: write-protect pages on transaction commit
Date:   Mon,  5 Oct 2020 21:48:37 -0300
Message-Id: <20201006004841.600488-1-mfo@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hey Jan, Andreas, Ted et al.

This series fixes the issue that buffers writeably mapped to userspace
can be modified during transaction commit, in between checksumming and
write-out to the journal, thus cause inconsistency in the journal that
prevents recovery/mount after kernel crash or power loss.

It's really ideas and patience from Jan guiding me how to write/fix it.
Huge thanks!

Although the synthetic test case in [v2] demonstrates the bug and that
the fix works, there's stress-ng tests that still causes inconsistency.

Unfortunately I couldn't look more into it yet; per discussion in [v4]
cover letter I'll send it as-is now, since it already fixes something,
and will continue to analyze. It might be something else/another fix.

There's also some fstests that _apparently_ become more flaky w/ the
patchset applied, but don't seem to be mmap() related.. so I'll look
at them more carefully too. The set of consistent failures (ie, that
happen most of the time) is the same between original/patched builds,
on both data=ordered and data=journal (different for each mode, ofc.)

    data=ordered:
    Failures: ext4/045 generic/044 generic/045 generic/046 generic/051
generic/223 generic/388 generic/465 generic/475 generic/553
generic/554 generic/555 generic/565 generic/611

    data=journal:
    Failures: ext4/045 generic/051 generic/223 generic/347 generic/388
generic/441 generic/475 generic/553 generic/554 generic/555
generic/565 generic/611

There's a small change to OCFS2 in patch 2, which has been tested w/
stress-ng's filesystem and io stressor classes; no regressions found.

    # mkfs.ocfs2 --mount local $DEV
    # mount $DEV $MNT
    # cd $MNT
    # stress-ng --sequential 0 --class filesystem,io

The only changes from v4 are style-change suggestions from Andreas
applied to patches 02/04 and where we set OCFS2 journal callbacks;
plus Reviewed-By: tags.

Tested on v5.9-rc7'ish and next-20200930; build tested on -rc8'ish
and next-20201002 today.

cheers,
Mauricio

[v4] https://lore.kernel.org/linux-ext4/20200928194103.244692-1-mfo@canonical.com/
[v3] https://lore.kernel.org/linux-ext4/20200910193127.276214-1-mfo@canonical.com/
[v2] https://lore.kernel.org/linux-ext4/20200810010210.3305322-1-mfo@canonical.com/
[v1] https://lore.kernel.org/linux-ext4/20200423233705.5878-1-mfo@canonical.com/

Mauricio Faria de Oliveira (4):
  jbd2: introduce/export functions
    jbd2_journal_submit|finish_inode_data_buffers()
  jbd2, ext4, ocfs2: introduce/use journal callbacks
    j_submit|finish_inode_data_buffers()
  ext4: data=journal: fixes for ext4_page_mkwrite()
  ext4: data=journal: write-protect pages on
    j_submit_inode_data_buffers()

 fs/ext4/inode.c      | 62 ++++++++++++++++++++++++++-----
 fs/ext4/super.c      | 87 ++++++++++++++++++++++++++++++++++++++++++++
 fs/jbd2/commit.c     | 62 ++++++++++++++++---------------
 fs/jbd2/journal.c    |  2 +
 fs/ocfs2/journal.c   |  4 ++
 include/linux/jbd2.h | 29 ++++++++++++++-
 6 files changed, 206 insertions(+), 40 deletions(-)

-- 
2.17.1

