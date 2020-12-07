Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC4D52D1479
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Dec 2020 16:11:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgLGPLK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Dec 2020 10:11:10 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:34855 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726311AbgLGPLJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Dec 2020 10:11:09 -0500
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 9FC2322E0A;
        Mon,  7 Dec 2020 16:10:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1607353827;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=wa7mfcuPecF7gpQwpDx0LYocwUQoOJPeyOlLst5l3R8=;
        b=RIfgFSsKMEbsurvMPnJmmDYSr/zCEVUWqyviNbBT1iB99U+CHdjE45zmy1kSxfPWOVj6AT
        7lLOLpk4uFdYRgUi+64kiWkoFm4N0SXkr13rPCBdR6kzxeKtvUGNTfQDmKaJ6q8yNMK/pP
        lO3D1rXFPS2vkWil61EWnsyd8cJY588=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 07 Dec 2020 16:10:27 +0100
From:   Michael Walle <michael@walle.cc>
To:     linux-ext4@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: discard feature, mkfs.ext4 and mmc default fallback to normal erase
 op
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <97c4bb65c8a3e688b191d57e9f06aa5a@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi,

The problem I'm having is that I'm trying to install debian on
an embedded system onto an sdcard. During installation it will
format the target filesystem, but the "mkfs.ext4 -F /dev/mmcblk0p2"
takes ages.

What I've found out so far:
  - mkfs.ext4 tries to discard all blocks on the target device
  - with my target device being an sdcard it seems to fallback
    to normal erase [1], with erase_arg being set to what the card
    is capable of [2]

Now I'm trying to figure out if this behavior is intended. I guess
one can reduce it to "blkdiscard /dev/mmcblk0p2". Should this
actually fall back to normal erasing or should it return -EOPNOTSUPP?

-michael

[1] 
https://elixir.bootlin.com/linux/v5.9.12/source/drivers/mmc/core/block.c#L1063
[2] 
https://elixir.bootlin.com/linux/v5.9.12/source/drivers/mmc/core/mmc.c#L1751
