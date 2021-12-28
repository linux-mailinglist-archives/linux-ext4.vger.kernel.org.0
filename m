Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABAAC4806FC
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Dec 2021 08:33:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233339AbhL1HdB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 28 Dec 2021 02:33:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbhL1HdA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 28 Dec 2021 02:33:00 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3ADC061574;
        Mon, 27 Dec 2021 23:33:00 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id e25so10723933qkl.12;
        Mon, 27 Dec 2021 23:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sg/CpOnxN4lgKydDlkk2DSIW+GFW5Y7TMeucVHnFkDU=;
        b=FNPbMRtSCOZ3RHlfOnJDxpsuNkmij1Oj/JSwgTbtqQLLC9/nwk3B/dr1CVlJtEbRSb
         lg/AivnHxG/LSIpUEDpktXpR+rWBVR6u+yV1B8jR4bc4jWgjdIrQlPxj9Oj9lAej601I
         lMpeTwKHZZtqP/4F3lpSfdK2lQ984DwSPCM5wrTQVmf7cNKnXajtbVkenrc4DzdKFM9N
         Tx7YubQ94uF16/a92OdDSPXABRsNSo5X3BlWOzCd+xqbnIqLdYSnsMD/nn1KBAUrO3/E
         Jt0sStn2eBe0dGY3KnoNqlhcKygo7UGRqprMeF3/mJP2vyb03GUum3ssZtsWL13x0MKc
         qgcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sg/CpOnxN4lgKydDlkk2DSIW+GFW5Y7TMeucVHnFkDU=;
        b=Gs81+rkXcDx45WR3XDUIo+2yhMtsCv7F2nnhzFMDOOZxP6ERZrKpZ9kNjizfEEQZKE
         xY6V3lLtDoDzJdkKNd+8gRoODKKMr0mdqDUMbGx2NpiOUdeSUZll09cDmMEFb62Cymq7
         bzbIwNKtgcA6qM05/UQ6NRsHjyg9KhHWSiix2Ltye3nFElkh0PYMQ5p/8TiTfbIrzVv+
         L9oNUijer76wo9X5yEs809phERq5cvh2sVY5cn7UyyY9wqhLG6Em/33SKAHQ3vzj+vBb
         C5bX7ZiYz85ZkcCh6dIcMQxhD0haXomf2sMPA2Qs5xQ+kpr8pvA1MAkjl9Hq+4D7qj3R
         h2Cw==
X-Gm-Message-State: AOAM531rg91YpxvSb9ciBoHhCufv5EjbaEs5svJo+doXcNMpdRa2NYXo
        oM9Wlpz88TLgQ4404oJxTPA=
X-Google-Smtp-Source: ABdhPJwijabZwKxzoxYwf946ZhepZ+X37k8gLJNfYDF3Ypi+u+MuL8T2Xti+6FviDj7xNs4CIADMTQ==
X-Received: by 2002:a05:620a:172b:: with SMTP id az43mr14314088qkb.567.1640676779941;
        Mon, 27 Dec 2021 23:32:59 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id d15sm15261874qtd.70.2021.12.27.23.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Dec 2021 23:32:59 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: xu.xin16@zte.com.cn
To:     lczerner@redhat.com
Cc:     adilger.kernel@dilger.ca, cgel.zte@gmail.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        tytso@mit.edu, xu.xin16@zte.com.cn, zealci@zte.com.cn
Subject: [PATCH resend] fs/ext4: use BUG_ON instead of if condition followed by BUG
Date:   Tue, 28 Dec 2021 07:32:52 +0000
Message-Id: <20211228073252.580296-1-xu.xin16@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211220102421.sggplg54ncsafcpi@work>
References: <20211220102421.sggplg54ncsafcpi@work>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: xu xin <xu.xin16@zte.com.cn>

BUG_ON would be better.

This issue was detected with the help of Coccinelle.

Reported-by: Zeal robot <zealci@zte.com.cn>
Reviewed-by: Lukas Czerner <lczerner@redhat.com>
Signed-off-by: xu xin <xu.xin16@zte.com.cn>
---
 fs/ext4/ext4.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 9cc55bcda6ba..00bc3f67d37f 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2400,8 +2400,7 @@ ext4_rec_len_from_disk(__le16 dlen, unsigned blocksize)
 
 static inline __le16 ext4_rec_len_to_disk(unsigned len, unsigned blocksize)
 {
-	if ((len > blocksize) || (blocksize > (1 << 18)) || (len & 3))
-		BUG();
+	BUG_ON((len > blocksize) || (blocksize > (1 << 18)) || (len & 3));
 #if (PAGE_SIZE >= 65536)
 	if (len < 65536)
 		return cpu_to_le16(len);
-- 
2.25.1

