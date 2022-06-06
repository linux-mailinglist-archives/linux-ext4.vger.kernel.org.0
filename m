Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD9453EC31
	for <lists+linux-ext4@lfdr.de>; Mon,  6 Jun 2022 19:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239668AbiFFO2y (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 6 Jun 2022 10:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239581AbiFFO2x (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 6 Jun 2022 10:28:53 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B877521249
        for <linux-ext4@vger.kernel.org>; Mon,  6 Jun 2022 07:28:52 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 744BC21A7E;
        Mon,  6 Jun 2022 14:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1654525731; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=HMJyjXvxX79kQpUk+2uLQR94qtxwivDAKY7AueCw6Ac=;
        b=Y8o0H/oE4sGgIMxSqTg/Sdx7eDYSGSm6XSxjSAZ7d1cHJVpVIlycEd9X9r8Vzic6GH8uda
        b42WsrCiDBxbbaYaTEw5NC1rZOTFCtH0d09iOrYAELS84xwLGwuuJZE58fz9XDThig7pu0
        o56BGJzL52B2xU6LmdigwehG3qKTK20=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1654525731;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=HMJyjXvxX79kQpUk+2uLQR94qtxwivDAKY7AueCw6Ac=;
        b=jA6+fzsE/QKg3xVPKvd4ur4WnFq+xL2vBdGQpK2zzS8yV+ZesIwyOPRh7P28ScUfaZKCji
        2SuEywQEPio/++AQ==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 61C142C141;
        Mon,  6 Jun 2022 14:28:51 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id F25D8A0633; Mon,  6 Jun 2022 16:28:50 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>,
        Ritesh Harjani <ritesh.list@gmail.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH 0/2] ext4: Fix possible fs corruption due to xattr races
Date:   Mon,  6 Jun 2022 16:28:45 +0200
Message-Id: <20220606142215.17962-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=717; h=from:subject:message-id; bh=Xt1ME9hPF0SsUNFcExgtTiKNeKYpbBbzPi3YB/GAwQQ=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBing8XlpS6bYCFt9KnEFP1mWuksjP6wJTs3hgEc1Cd C/8BlZeJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYp4PFwAKCRCcnaoHP2RA2Yx6B/ oDc50iInEPGSHuvDvxPRIKrcK8ip1aUl8/dtCZ110bscsR93AnLIaz9vUynqQ4l7mQcY5ND/v9hL+8 31eQ9Ouo7qERoFwKYtKg8JKGE0JBdirR7DuP9GUoRzJnHxvLXrawWgVvX9soLteRx0lsrN796AjO0y FQ7LAGwle6Ij+PaPxH5pO6HH93fkSl8qTFHS/2NVhFe/ikwdD4tV/wWDN1b1lryf5Q9UzX8N3Q1qWD ps0U3ZH9hYk4M0N8Lf8MMZ9Z8jvdUwWeadPq1IvmnoZm28j2tq2pFv1BfWJmejiZVSMFIWEvZ6Louc 4oPGcxm22DR/m0PHZwiIxYnm0LYAo9
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

I've tracked down the culprit of the jbd2 assertion Ritesh reported to me. In
the end it does not have much to do with jbd2 but rather points to a subtle
race in xattr code between xattr block reuse and xattr block freeing that can
result in fs corruption during journal replay. See patch 2/2 for more details.
These patches fix the problem. I have to say I'm not too happy with the special
mbcache interface I had to add because it just requires too deep knowledge of
how things work internally to get things right. If you get it wrong, you'll
have subtle races like above. But I didn't find a more transparent way to
fix this race. If someone has ideas, suggestions are welcome!

								Honza
