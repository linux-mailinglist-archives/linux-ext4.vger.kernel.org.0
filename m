Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A640B568B0E
	for <lists+linux-ext4@lfdr.de>; Wed,  6 Jul 2022 16:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233073AbiGFORb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 6 Jul 2022 10:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbiGFORZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 6 Jul 2022 10:17:25 -0400
X-Greylist: delayed 1028 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 06 Jul 2022 07:17:24 PDT
Received: from fish.birch.relay.mailchannels.net (fish.birch.relay.mailchannels.net [23.83.209.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9047E18B25
        for <linux-ext4@vger.kernel.org>; Wed,  6 Jul 2022 07:17:24 -0700 (PDT)
X-Sender-Id: wpengine|x-authuser|c1b88d7c3cd0d539af12decb0aab68242f0e4b67
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 2CF245A20DA
        for <linux-ext4@vger.kernel.org>; Wed,  6 Jul 2022 14:00:15 +0000 (UTC)
Received: from pod-100132 (unknown [127.0.0.6])
        (Authenticated sender: wpengine)
        by relay.mailchannels.net (Postfix) with ESMTPA id 140305A21BE
        for <linux-ext4@vger.kernel.org>; Wed,  6 Jul 2022 14:00:13 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1657116014; a=rsa-sha256;
        cv=none;
        b=CdD5sjPA/cRMLAM6SabfJgj8IHds0YJfcqWCCsYLBnUq0K1X5QRx15DclolGWNqGAv/wRX
        XVkqrA7RZYpGYce0S2fLlZSJ7/GvIMzT1mbvcTlEwSbn6Ap0xixjzqWghpmjQG54fRaMbb
        okYcChpID3vz+/ZOvdj4Osvs9Bu1kHHupdDnyaTVV/mEGo5Sp8GSF3/YRy+mXZghsv7cve
        gWYCk3nknHTP/KLw9w/cYBiHBp5NQ48zjQp+4dkvjRopWXWn49E+HrHbQIffElE7E9RIfk
        mkWASbb1sItps7FyEHpK9xdOtPvcw8R2NP1V78g9EUlARrT2goz/wUre77BR/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1657116014;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:dkim-signature; bh=PcU45Zm+n4WVLaMtiL8B/NjKwXABkbG5ohKEG5Mx9Pc=;
        b=uT12VW+xx5uxh6qJokpH66aq2ce+9/AZx8puuv0wY2/Uckd+dPR0HKBGwZIB8rn4HVlAJs
        /4RQgZ+L5oqryUBE7xkyBYx2wSNI3tJdt9Cp72ph3U5XDPLyd84/AqvMRTOaq663jRKtFy
        tzGgxHgZiDsIWtNeatUYHJp2rb/gTOCAPUKbvPgZbyDGMoqktOh0ilaLP/O7hjli9xwl6H
        LyYsMZlRCPWA3DekdQ1M5HpVXcvlGq6g7XyLcpJiM9HBfq6lbQ5R/0K3XcduaYraTJts/R
        dVgCX5faa4ou0p2NiPwE3Km3Rnb7KpBViRITIp55bwPWiStioUY/r3NWohpzzw==
ARC-Authentication-Results: i=1;
        rspamd-689699966c-9r7cm;
        auth=pass smtp.auth=wpengine
 smtp.mailfrom="support=bodynutrition.org@mail1.wpengine.com"
X-Sender-Id: wpengine|x-authuser|c1b88d7c3cd0d539af12decb0aab68242f0e4b67
X-MC-Relay: Bad
X-MailChannels-SenderId: wpengine|x-authuser|c1b88d7c3cd0d539af12decb0aab68242f0e4b67
X-MailChannels-Auth-Id: wpengine
X-Trouble-Blushing: 1391f8f7632baddc_1657116014921_1030627791
X-MC-Loop-Signature: 1657116014921:1691723455
X-MC-Ingress-Time: 1657116014920
Received: from pod-100132 (121.250.197.104.bc.googleusercontent.com
 [104.197.250.121])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.123.97.133 (trex/6.7.1);
        Wed, 06 Jul 2022 14:00:14 +0000
Received: from pod-100132 (localhost [127.0.0.1])
        by pod-100132 (Postfix) with ESMTP id DE1C83F8DB
        for <linux-ext4@vger.kernel.org>; Wed,  6 Jul 2022 14:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mail1.wpengine.com;
        s=mx; t=1657116013; bh=YR9fpzaOrhVNepwvRkG1OniLBvufAJdbxR31Vcvu+ks=;
        h=Date:To:Subject:From:From;
        b=VLsFFBso6ERn2rYqbyauxwi1llp3tpDEix5rGb0ugMZ/eNyU9sq0u6abM5kzCOOkJ
         RiHPUQ+5IZuamBNVBb8osXl0uNYljoxnrosSx5HG/ruLfjBWOWGRFgPWMq8DtJZ8sp
         NKsVm4EZku3MBt2lZUG1M72JOuEDr9aJHmWBns0Twf31pc8XHOtFNfrsdS9TwGuv6j
         sZ3xeL7rsgdHJCa/TJP4sa3+xt710k21QeZolT0UB9rgHc/pfcMMPpNTfdBv4QaAU7
         BGndJjBbK7lc3NCsAxXvLV3nKHQa/ponFUrsT8V9vujP4iWhjnBy/1zPKehJd529z2
         fwnPFpkqlebow==
Received: from pod-100132:apache2_74:248 (localhost [127.0.0.1])
        by pod-100132 (Postfix) with SMTP id 8FE683FE3E
        for <linux-ext4@vger.kernel.org>; Wed,  6 Jul 2022 10:20:32 +0000 (UTC)
Received: by pod-100132:apache2_74:248 (sSMTP sendmail emulation); Wed, 06 Jul 2022 10:20:32 +0000
Date:   Wed, 06 Jul 2022 10:20:32 +0000
X-AuthUser: c1b88d7c3cd0d539af12decb0aab68242f0e4b67
To:     linux-ext4@vger.kernel.org
Subject: Your Macro Calculator Inputs
X-PHP-Originating-Script: 33:macro-admin-email-data-optin-calculator.php
From:   support@bodynutrition.org
Message-Id: <20220706102032.8FE683FE3E@pod-100132>
X-Spam-Status: No, score=3.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,PP_MIME_FAKE_ASCII_TEXT,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SHORT_SHORTNER,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Here are Your Macro Calculator Inputs: 

Name: 😘 Have you ever tried this sex game before? GIVE IT A TRY: https://letsg0dancing.page.link/go?qqgi 😘
Phone: 278120430621
Email: linux-ext4@vger.kernel.org
Comments: 1cnlkf
CARBS: tezhhl GRAMS per day
PROTEIN: 3qzblg GRAMS per day
FAT: yall62 GRAMS per day
FIBER: yc9y40 GRAMS per day
CALORIES: 56prki GRAMS per day
