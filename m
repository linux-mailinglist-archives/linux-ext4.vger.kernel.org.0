Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67AE87E170D
	for <lists+linux-ext4@lfdr.de>; Sun,  5 Nov 2023 22:59:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbjKEV7x (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 5 Nov 2023 16:59:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjKEV7w (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 5 Nov 2023 16:59:52 -0500
X-Greylist: delayed 5176 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 05 Nov 2023 13:59:49 PST
Received: from SMTP-HCRC-200.brggroup.vn (unknown [42.112.212.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E7C112
        for <linux-ext4@vger.kernel.org>; Sun,  5 Nov 2023 13:59:49 -0800 (PST)
Received: from SMTP-HCRC-200.brggroup.vn (localhost [127.0.0.1])
        by SMTP-HCRC-200.brggroup.vn (SMTP-CTTV) with ESMTP id DE46A19176;
        Mon,  6 Nov 2023 01:57:52 +0700 (+07)
Received: from zimbra.hcrc.vn (unknown [192.168.200.66])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by SMTP-HCRC-200.brggroup.vn (SMTP-CTTV) with ESMTPS id D7974192C0;
        Mon,  6 Nov 2023 01:57:52 +0700 (+07)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.hcrc.vn (Postfix) with ESMTP id 7425C1B8223A;
        Mon,  6 Nov 2023 01:57:54 +0700 (+07)
Received: from zimbra.hcrc.vn ([127.0.0.1])
        by localhost (zimbra.hcrc.vn [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id qw_MmGeRPQMB; Mon,  6 Nov 2023 01:57:54 +0700 (+07)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.hcrc.vn (Postfix) with ESMTP id 40FB41B8204A;
        Mon,  6 Nov 2023 01:57:54 +0700 (+07)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra.hcrc.vn 40FB41B8204A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hcrc.vn;
        s=64D43D38-C7D6-11ED-8EFE-0027945F1BFA; t=1699210674;
        bh=WOZURJ77pkiMUL2pPLC14ifVPRvyTQIBEQmxuN1ezAA=;
        h=MIME-Version:To:From:Date:Message-Id;
        b=PrWbE4KMdmEG3nHViBv/en6yMNfTiBT8+xCFBfI1MpfLkvwSA2e1T5x9cP3MJZtpy
         3cbe5WJn//7fenB/apf3U7g2Nmi/SrDtmF/RQN0XvOxt4iWnoczLUwo5nLmud0+hUs
         +Cmz709FbpVlB4lKkN+kZE/MMcqqUA3iX//DEpQqbgQNSe6MxAj3Fl6JibYTMD+23V
         4a9yXNVS2fLsJYlqB16ns4RlCNPgdocoKI+28m+JgOjO9iwFnZhtt2R683rkMalxwB
         SLmM4Lhk3X/PXMVJFSTniGv6efimoqnyJcFn9jCpOgTbWoozrGh9h7sJ6DFpWTAUNn
         JeVepzX9mxf+w==
X-Virus-Scanned: amavisd-new at hcrc.vn
Received: from zimbra.hcrc.vn ([127.0.0.1])
        by localhost (zimbra.hcrc.vn [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 4KBUHDiSpDJE; Mon,  6 Nov 2023 01:57:54 +0700 (+07)
Received: from [192.168.1.152] (unknown [51.179.100.52])
        by zimbra.hcrc.vn (Postfix) with ESMTPSA id D4EFA1B82538;
        Mon,  6 Nov 2023 01:57:47 +0700 (+07)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: =?utf-8?b?4oKsIDEwMC4wMDAuMDAwPw==?=
To:     Recipients <ch.31hamnghi@hcrc.vn>
From:   ch.31hamnghi@hcrc.vn
Date:   Sun, 05 Nov 2023 19:57:37 +0100
Reply-To: joliushk@gmail.com
Message-Id: <20231105185747.D4EFA1B82538@zimbra.hcrc.vn>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Goededag,
Ik ben mevrouw Joanna Liu en een medewerker van Citi Bank Hong Kong.
Kan ik =E2=82=AC 100.000.000 aan u overmaken? Kan ik je vertrouwen


Ik wacht op jullie reacties
Met vriendelijke groeten
mevrouw Joanna Liu

