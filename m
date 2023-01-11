Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B566665F90
	for <lists+linux-ext4@lfdr.de>; Wed, 11 Jan 2023 16:46:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239479AbjAKPqt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 11 Jan 2023 10:46:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238492AbjAKPq1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 11 Jan 2023 10:46:27 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA5C33B91C
        for <linux-ext4@vger.kernel.org>; Wed, 11 Jan 2023 07:44:09 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4D2324CDD;
        Wed, 11 Jan 2023 15:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1673451819; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=z5ZrJlQkxZx9CsViJbrTWVWqR8IS91864hNdz+vs1xw=;
        b=zevMPDlazAhyZEv+nu1snjlQ/6Odx5iyIVn5xF/z3jgIEUgJogyyZeKzq9tqiVnr6B41Fn
        jVlt/ei1hrqmlNpXEU/M+DSi310AX+z3zVWf+cqU+eznwhgN8a+XF/TLZD/H0Y0o4DmezX
        WqELiQYj2vitelfSpJDcgRyDpdRxOR8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1673451819;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=z5ZrJlQkxZx9CsViJbrTWVWqR8IS91864hNdz+vs1xw=;
        b=8hPYw9vr5d9zhSaSiztrTQR7xofByR2Xzh5pPOtNeWuZNOHfTyV6zgQdyLbAqjaAj7Nm81
        zxdRcpNmn/DKv4Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3696513776;
        Wed, 11 Jan 2023 15:43:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 58pRDSvZvmO8OwAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 11 Jan 2023 15:43:39 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 13C16A0744; Wed, 11 Jan 2023 16:43:38 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 0/7] ext4: Cleanup data=journal writeback path
Date:   Wed, 11 Jan 2023 16:43:24 +0100
Message-Id: <20230111152736.9608-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=969; i=jack@suse.cz; h=from:subject:message-id; bh=N+pqz/JilUmyeFE/VNUJX5YXuwxOR9NVFr0gfMi8/Vw=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjvtkXGb2RaYzQu7y5qJp9LT3OT3Na8d+SfhtgweUv Dm6d5VGJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY77ZFwAKCRCcnaoHP2RA2ZAcCA C9zpMCsmNlBbMZ1iMmybBY6VIqcyC1Wmhzq8xZE1Ly2U9w9LUN8zEy4rIIDRpJhUeyl2DX7ARECXyz n5ckddMp9WTS4hQ5DWvgENoqSquPLNFF3bF2JrHTkzxR8zjX50AYlVsv1FovgCBrK+dgf+tUspZyY3 YavEHn1/LL94m0UG6AyrTYz8lFjF0QNUtigw02p18zfzCtdB/BayxJGOWVLJEhvhjfcXt8Jm85VtFH r4A0X8MKA+Eq36G0PEaCr+m/yKk3F3T+Oioj1fd9PPLK5guVVeHZmiObQvTWnnt+wAXZXBD0H09oSB d5et4gsHGAn5biYRDCM0BtfjKYA9S3
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

this patch series implements promised cleanup of ext4 data=journal writeback
path. That way we can get rid of last remnants of old support for .writepage
callback and mostly unify this writeback path with standard data handling
modes. We also update some of the stale comments regarding data=journal mode
along the way.

Note that patch 3 (ext4: Mark page for delayed dirtying only if it is pinned)
currently breaks somewhat the data=journal guarantees if mapped page cache is
used as a buffer for direct IO read because that path does not pin pages yet
(David Howels is working on it). But I figured this is not a huge deal for a
cornercase usecase of a cornercase configuration and keeping marking page for
delayed dirtying unconditionally is problematic as checkpointing dirties the
page as well so it is effectively permanently added to the journal. It was
problematic already in the past and happened to work only by luck.

								Honza
