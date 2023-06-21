Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB74873879B
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Jun 2023 16:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232193AbjFUOsE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 21 Jun 2023 10:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232112AbjFUOr5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 21 Jun 2023 10:47:57 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC5A1BC8;
        Wed, 21 Jun 2023 07:47:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6E5D121D31;
        Wed, 21 Jun 2023 14:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1687358865; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=krazhDqkkI6wNXu0ll9SV+HdWkc5RkM6Hun6fu2TkJs=;
        b=GtBjzesMY7ziWNesTZ+iw9f+LzMhYL5YcYwQIbPJ8wR1/W78AcYUTkpF4+eHPgMzValyLl
        xY+SPXFHCXVv86DoE+LDJn+/e4+UCyuzjYgu4sobw7emZ8KJaH+Me1GcyCWOGDDzHKMXEd
        qictKcYgLEBjeRKNRLzEswreR3xNGL0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1687358865;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=krazhDqkkI6wNXu0ll9SV+HdWkc5RkM6Hun6fu2TkJs=;
        b=J9o7reMXwwL11bX57ZoPvjej7A3xalVUdYSR6VHPyfIMuehFL+gtS7IjAysNcYRWpboIgA
        L6a64E1ECnCqwWBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 52A4C13A6D;
        Wed, 21 Jun 2023 14:47:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ZSAkFJENk2QAEQAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 21 Jun 2023 14:47:45 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id C53F3A075D; Wed, 21 Jun 2023 16:47:44 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        <linux-ext4@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 0/2] fs: Fixup bdev_mark_dead callbacks for ext4 and xfs
Date:   Wed, 21 Jun 2023 16:47:41 +0200
Message-Id: <20230621144354.10915-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=264; i=jack@suse.cz; h=from:subject:message-id; bh=BiSFepMSHltOxLj7FLxaUxptUJ6xX0ti4qvsnBTEaSY=; b=owGbwMvMwME4Z+4qdvsUh5uMp9WSGFIm87aLyjD/cjP8nznrWAhDzZ6GkzzMj7MX7b5d8LspIbuk ZcGzTkZjFgZGDgZZMUWW1ZEXta/NM+raGqohAzOIlQlkCgMXpwBMRD2E/Tfb8bAntXncWTG3BQJ/vv t4VWBnt4ykYMgX8eU9m6KPzmAJLjb2+xpcF7/ITXBdjOitIK1QuxXxNQu3iBo5KvW0vd8e5/o4ueaZ 1u07+8tvf5pU+iqxV0Jfr/XLz1argENGO6wv3Zyu+7E8z/nzT/Ug5oBH/G0/90srvVhqqZBVJRy2t7 uS+43oJgb/g0vTbNc/eawmcd6p5k12+Kbq41+3zZntzaXpa3gx7KBGb6Sc3e+OU8x2lnFvXltLx65/ tP18yYZ95x18Zme2v99jcfZpXuGTFoF0Dr6GsJKoQOPVSRtf7ZBqqNluoSBtpf+3pT1bd+ZvwZ2PG9 OrVR9eShdxCH+08l7hEbVNyXr5AA==
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

Jens, I have found out the recently added handlers (sitting in your tree) of
.bdev_mark_dead callbacks in xfs and ext4 were wrongly using bdev->bd_holder
instead of bdev->bd_super and so they could never work. This series fixes them.

								Honza
