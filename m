Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC1996C6B9D
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Mar 2023 15:54:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjCWOyM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 23 Mar 2023 10:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231673AbjCWOyK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 23 Mar 2023 10:54:10 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12768193F3
        for <linux-ext4@vger.kernel.org>; Thu, 23 Mar 2023 07:54:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6CF5A1FE54;
        Thu, 23 Mar 2023 14:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1679583245; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=ZcJrGzhHByPSzpppID6b3QFV7NR8MbQoeqWk6c4rNRw=;
        b=jXUvs6EpstWciAAXyjAnqxE1IH4lJSmt/C3pf/KSQrDGkucrCovOuTpDsL6W+7rmfqUf37
        2XytigoKX3g0wpE6QiC/xg/Af4kUUEsK7VGOSiZpdn17coYd6E8GM4JEL8HARFyY+Gn5jY
        UD0RS3NjE6KFwdGdXl4IH+YynM7cAnM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1679583245;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=ZcJrGzhHByPSzpppID6b3QFV7NR8MbQoeqWk6c4rNRw=;
        b=LpMokttL9Z5ysuykxUYyAw0OQ/LXsGQDWp/LPpc/3Dq84cvW7g3LS45rEerjDo9lOF63g2
        IAgTeGA2lRz0AsDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5AEAD132C2;
        Thu, 23 Mar 2023 14:54:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RqUoFg1oHGSWDwAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 23 Mar 2023 14:54:05 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id BEE1AA071C; Thu, 23 Mar 2023 15:54:04 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Eric Biggers <ebiggers@kernel.org>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 0/2] ext4: Fix two bugs in journalled writepages rework
Date:   Thu, 23 Mar 2023 15:53:57 +0100
Message-Id: <20230323145102.3042-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=120; i=jack@suse.cz; h=from:subject:message-id; bh=j6gs6b3aODdOtAtAwNgZt0/O5CQ+fYFlevsRJOzhLa4=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBkHGf/Cl5LDv/0q1hVYish3zFQ34+c2E+3/N9eUwp8 lcx+LvWJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZBxn/wAKCRCcnaoHP2RA2YzECA C59Yh6pQNcQrqMjGcZRM2wfg8kwVf1WiMi6NkpN7y4AbD9NKJ5GRULzoMnJyEh6YfVxCePgk9Xayb0 Sg4RCnwfPtfl98RwxbxyMNqRkn3vA+TqFf9Rab73s+5GI+O+hQVQ/kvCn/mcwRVgiZdUA8k3u3xdYu RCGAEbiuwqwiUuSSZX+Wjz9fgd+dX162FvB+YxNv3owWPNs8GZ0vE5dU+BXScVHgVUDAKcfe0kiGmj 3CUyFFxIx+1I1msEwqXPqjwjz2srDPnFH9+XNpTB3Ih1/WXBj1662tOfRgRwb1kgGZ1cQ0aEp9Lowa mH6WcLie8sahfAZSUb/XJ8hXW7Bmh3
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

Hello!

These two patches fix two problems introduced by the rewrite of journalled
writeback path.

								Honza
