Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1EC7336A0
	for <lists+linux-ext4@lfdr.de>; Fri, 16 Jun 2023 18:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345747AbjFPQwN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 16 Jun 2023 12:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345818AbjFPQvU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 16 Jun 2023 12:51:20 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4643AAB
        for <linux-ext4@vger.kernel.org>; Fri, 16 Jun 2023 09:51:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 30EB81F8CD;
        Fri, 16 Jun 2023 16:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686934270; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=BD+D/eo006GkddpWGCOfJJnbdJJNYnwYRSTC3Zr1JDo=;
        b=x9O4Jwz1h01Qin92VqVcVqt5qZddMEavjcBXJh+VOdaPtedamHetjVrz3oajgqyQlLxsIB
        mV/qWlOhJKAY3KvriyvErosujhpNIauo1IxT0W0Dmlw3UDuf/MIyQlUZ7dGPCbWQrVU6Kx
        8JGpbmtFRQfSWQAlVvbuyqJ1Y/HsQnQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686934270;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=BD+D/eo006GkddpWGCOfJJnbdJJNYnwYRSTC3Zr1JDo=;
        b=rg9Dirgf2twBCio1OV842iwAWXzF6n+hZXao0JBf0MZ37+LJxN6M7QRfTqSM3OJR59+/iz
        aOAl3H+dvBnsyVDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1DE331330B;
        Fri, 16 Jun 2023 16:51:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Wr+PBv6SjGQsIwAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 16 Jun 2023 16:51:10 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 6E24FA0755; Fri, 16 Jun 2023 18:51:09 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 0/11] ext4: Cleanup read-only and fs aborted checks
Date:   Fri, 16 Jun 2023 18:50:46 +0200
Message-Id: <20230616164553.1090-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=404; i=jack@suse.cz; h=from:subject:message-id; bh=2VrXCK/XJajw4r6PRSpg1un3esa+LUT3c89Yj74AAAE=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBkjJLgjdUErrciO4t6mqGWP06he65VrL4+nC3lURiD t4Y7yAqJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZIyS4AAKCRCcnaoHP2RA2dhIB/ 0Sl9si+NUxxxfsjiEk+Lz7oZl9bc+DBkQ6FrpWLGyB/HIwWGAiy263VfAPoMOS+jvH6vmofpkn5uzR D7Wdoo/QANPfUHiedjlQDYVrGeaR4So7u5h/YFeuUk1Fw7b0HLEtu0JzsZX6onpfOLZwV8CQnxID9X GkqPaijVQs36ntF0c+caJfx3mYJ9RoBiJFSKbPaNZC0wKMdTyvznqxw2ZWLANhONkgXg68zBYTtFVM PRyiBHbl0OeR2L+BrEBuffrgdRkZFypajIRWmasXuSxo7+6FrP0IiwE2/5xlemXTfVu1VNwAB8k9KD 77mxWJVDpldiv5n/377V8Vfwa6hvZF
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

This series arised from me trying to fix races when the ext4 filesystem gets
remounted read-write and users can race in writes before quota subsystem is
prepared to take them. This particular problem got fixed in VFS in the end
but the cleanups are still good in my opinion so I'm submitting them. They
get rid of EXT4_MF_ABORTED flag and cleanup some sb_rdonly() checks.

								Honza
