Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 738C0209749
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Jun 2020 01:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387828AbgFXX4c (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 24 Jun 2020 19:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728035AbgFXX4b (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 24 Jun 2020 19:56:31 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F95CC061573
        for <linux-ext4@vger.kernel.org>; Wed, 24 Jun 2020 16:56:31 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id p20so4125825ejd.13
        for <linux-ext4@vger.kernel.org>; Wed, 24 Jun 2020 16:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=hzYmUdowX/9ohN1yOJtSuqA6+VsT6eBxnBFftF12pAk=;
        b=QzQI+lkIPD7JbBGXuSwo9Exikbf0Pfw4AVh6Ai43iW1mtILH1CZBCBj8gaGPAMRE2z
         Tjqko8599YnQKyoH/KZJcoN9RkWp5vYur65uUi+hF9Q2AXO2Kx3t7AprQ/biaCRPqPUy
         ls22VVFiGwUircLi3Oal4iynAPmd+7bPKVl94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=hzYmUdowX/9ohN1yOJtSuqA6+VsT6eBxnBFftF12pAk=;
        b=UPoPUkyM3NbGnxLMbixcIhKzlVAPO0JQqiYtBc254SC96Czauwgt8dYhCL8ikvob7q
         tPepdOqCNQD7sCAsCAK4Kk08dEM+daEeic2K61NeF1+m8YC5KruMrbvNHklOp6vVJW1D
         b/XHZgd6h3YLg85UFFKBXqhTufJ3ytJintM1dbOb/PFEVT1BzZhhNkgbJ0Y3qN6vpLn/
         mIYW1SmyQY5ggETB6b5yvpfmCjVLFzFSqGtK8ENjuMMM8P3pRXaftmKrNGPvw3lBR+Cw
         sTlSjV9P1hxWgLnLJV2zQbupskMOFuoeuEQJk8rS8RXVGajMXVFMpWajIlXqoUN6smlP
         Eq0A==
X-Gm-Message-State: AOAM530HsahtqbE4WSj5q+9rz4DBoH9/jgv11+keXiXNsTwtpOzjNWas
        uXsLQyR8zdZpT4hma3yp8Ofvqwf1bllqS3R1E6OQ/ljOQ28=
X-Google-Smtp-Source: ABdhPJwlK40lb+XSj0kn80FqYC/Cks6MC2mQBbI4KR9SwLmQoRE3tpOofePYqDiH5lf5GOXJVI+q5u4Uw7gNl9aqpMc=
X-Received: by 2002:a17:906:4d13:: with SMTP id r19mr26871308eju.45.1593042989478;
 Wed, 24 Jun 2020 16:56:29 -0700 (PDT)
MIME-Version: 1.0
From:   Costa Sapuntzakis <costa@purestorage.com>
Date:   Wed, 24 Jun 2020 16:56:18 -0700
Message-ID: <CAABuPhaMHu+mmHbVKGt2L0tcE2-EMyd5VWcok7kAfJY3DQ=-vw@mail.gmail.com>
Subject: [BUG] invalid superblock checksum possibly due to race
To:     linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Our workload: taking snapshots repeatedly of an active ext4 filesystem
(vdbench fwiw). e2fsck discovered a snapshot that had a corrupted
superblock after journal replay. Diffing the corrupted superblock to
the superblock before journal replay revealed that only s_last_orphan
and the checksum had changed.

The following race could explain it:

Thread 1 (T1): ext4_orphan_del -> update s_last_orphan to value A ->
ext4_handle_dirty_super -> ext4_superblock_csum_set -- PAUSE right
before setting es->s_checksum

T2: ext4_orphan_del -> update s_last_orphan to value B ->
ext4_handle_dirty_super -> ext4_superblock_csum_set runs to completion

T1: Resume and assign es->s_checksum

Is there higher level synchronization going on that makes this race benign?

If not, a spinlock around the calculation and assignment should fix it.

The spinlock still has the race where s_last_orphan is being updated
while the checksum is calculated. But the last thread to set
s_last_orphan will also eventually try to recalculate the checksum and
set it right (though it's possible some other thread will do it for
it). And I'm guessing/hoping jbd2 won't flush the superblock to the
journal and close a transaction until the references from
journal_get_write_access drain. The checksum is recalculated before
the get_write_access reference is dropped.

-Costa
