Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC664B9BF7
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Feb 2022 10:26:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238672AbiBQJZr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 17 Feb 2022 04:25:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238671AbiBQJZq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 17 Feb 2022 04:25:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 79FC02819A1
        for <linux-ext4@vger.kernel.org>; Thu, 17 Feb 2022 01:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645089922;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Edjx8h2juGd0cjEmGmnbYSBnXr2+Jz4WeDLNAj9gRxQ=;
        b=cPHCOdEJcuNhzk/euEaTLM0VlvNH60OYawlScSikLe714ineDCRuq/Da7L6IC3K10H/PcI
        p7fyuwKVAB+R50/jzZPw8tiIEX8+RlPk/j08dzdgic0DJtN1fbeMbodsGetwmAZ661Tk4b
        sR/oleYVI3HDbkS8tJF+N7l2JY2hV3I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-632-dxZJD0c2MXSZ6Us2bTrzKw-1; Thu, 17 Feb 2022 04:25:19 -0500
X-MC-Unique: dxZJD0c2MXSZ6Us2bTrzKw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 73C22814243;
        Thu, 17 Feb 2022 09:25:18 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.194.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B27AE7B6C7;
        Thu, 17 Feb 2022 09:25:17 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     tytso@mit.edu
Cc:     linux-ext4@vger.kernel.org
Subject: [PATCH 2/3] libss: fix possible NULL pointer dereferece on allocation failure
Date:   Thu, 17 Feb 2022 10:24:59 +0100
Message-Id: <20220217092500.40525-2-lczerner@redhat.com>
In-Reply-To: <20220217092500.40525-1-lczerner@redhat.com>
References: <20220217092500.40525-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Currently in ss_execute_command() we're missng a check to see if the
memory allocation was succesful. Fix it by adding SS_ET_ENOMEM error and
checking the return from malloc.

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
---
 lib/ss/execute_cmd.c | 2 ++
 lib/ss/ss_err.et     | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/lib/ss/execute_cmd.c b/lib/ss/execute_cmd.c
index d443a468..0bcaa54d 100644
--- a/lib/ss/execute_cmd.c
+++ b/lib/ss/execute_cmd.c
@@ -171,6 +171,8 @@ int ss_execute_command(int sci_idx, register char *argv[])
 	for (argp = argv; *argp; argp++)
 		argc++;
 	argp = (char **)malloc((argc+1)*sizeof(char *));
+	if (!argp)
+		return(SS_ET_ENOMEM);
 	for (i = 0; i <= argc; i++)
 		argp[i] = argv[i];
 	i = really_execute_command(sci_idx, argc, &argp);
diff --git a/lib/ss/ss_err.et b/lib/ss/ss_err.et
index 80e9dfa4..f7238da0 100644
--- a/lib/ss/ss_err.et
+++ b/lib/ss/ss_err.et
@@ -36,4 +36,7 @@ ec	SS_ET_ESCAPE_DISABLED,
 ec	SS_ET_UNIMPLEMENTED,
 	"Sorry, this request is not yet implemented"
 
+ec	SS_ET_ENOMEM,
+	"Not enough memory"
+
 	end
-- 
2.34.1

