Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFD8E6CED60
	for <lists+linux-ext4@lfdr.de>; Wed, 29 Mar 2023 17:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjC2Pt6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 29 Mar 2023 11:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjC2Pt5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 29 Mar 2023 11:49:57 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C824690
        for <linux-ext4@vger.kernel.org>; Wed, 29 Mar 2023 08:49:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 781BD1FDFF;
        Wed, 29 Mar 2023 15:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1680104995; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=WwY1T459VMFvhOPvUbMAYHK0ApbyLxfkOlobMW3zAmY=;
        b=hhJJJAIQwtO10IYST4CLsqgjdNO+rX/O1mdlDiJJEJqt+yqG7XFh9ceqcWOK8cMM1LhdFb
        DS509f0+cBqHTrsZ0t8jjA5F98dMFAyRHuPWIfUiiAT2tJd5tRNzfPrOky/IAvVSPKAHQ4
        z3TSL5SaVjC7YRj2UkMDnnqOAHhnhmw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1680104995;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=WwY1T459VMFvhOPvUbMAYHK0ApbyLxfkOlobMW3zAmY=;
        b=ATuBKxCXNqdTRPTLjW8WPX5AdfX3sBx6YM1UpCv80wbvewkjh208pFZZwiextcNho7oytA
        I0RmX2pYn7esyPDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C4C0F138FF;
        Wed, 29 Mar 2023 15:49:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Ri2SLyJeJGQwYwAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 29 Mar 2023 15:49:54 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 298C5A071E; Wed, 29 Mar 2023 17:49:50 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 0/13 v1] ext4: Make ext4_writepages() write all journalled data
Date:   Wed, 29 Mar 2023 17:49:31 +0200
Message-Id: <20230329125740.4127-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1247; i=jack@suse.cz; h=from:subject:message-id; bh=NA359qnZPj2j+lzgQd4wusi65HVFfFNfe4zWPNbQoes=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBkJF3zkarThMT06xwbLzqXVkO2aGh/HSZUmpaDFwPF Uo5a7PWJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZCRd8wAKCRCcnaoHP2RA2ZhcB/ 0bXnYSO34G4WbT4GpYy8alsOh3qEEv8T21qH0REOkk3nonTmOu3fqK2no8Z4hDMmCuJWfPmdSGCMcP +zcI2lucd8Af1i/qN38HYKlKpsvz09z3Fjy2Hr1J8Qa+tUlD/GJ1/BmZcohFksHSFA1abiMtjhGiBr E4I5t6PF/q0m8m8kA4EBuN2pVoRjlRQpUc2DF69N7yMPvFvsr6nn4E/3tTdoz1AnzEHmcMCY6sOCUK TJeTyWzhyXmfkgWmb0r306cDA+zg2nktghQ/3ZcMFsq4OU4mI0DlFvH7+BhJORc80izGI/+ZI4FRah 1SkYcOFhHJOiZS6Y3rBV92GNDnjHpf
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

These patches modify ext4 so that whenever inode with journalled data is
written back we make sure we writeout all the dirty data the inode has.
Previously this was not the case as pages with journalled data that were still
part of running (or committing) transaction appeared as clean to the writeback
code. As a result we can remove workarounds for inodes with journalled data
from multiple places.

In particular, we make sure a page is marked as dirty as soon as it has any
data to write (even though it is part of the running transaction) and in
ext4_writepages() we make sure appropriate transaction is committed (in
WB_SYNC_ALL mode) and then go writing back pages (effectively performing a
checkpoint for the inode). Thus after WB_SYNC_ALL writeback all pages for the
inode are guaranteed to be clean (providing there were no new pages dirtied)
the same way this is guaranteed for non-journaled data.

The downside of this change is that workloads that use journalled data and
frequently redirty pages and call fsync(2) will see more IO happening (more
pages will get checkpointed). But given low amount of users of data=journal
mode and their nature, I deem the code simplification worth it.

								Honza
