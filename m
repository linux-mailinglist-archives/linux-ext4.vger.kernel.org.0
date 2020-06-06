Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF5DA1F07F4
	for <lists+linux-ext4@lfdr.de>; Sat,  6 Jun 2020 18:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728714AbgFFQpb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 6 Jun 2020 12:45:31 -0400
Received: from mail.thelounge.net ([91.118.73.15]:48443 "EHLO
        mail.thelounge.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727989AbgFFQpa (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 6 Jun 2020 12:45:30 -0400
Received: from srv-rhsoft.rhsoft.net (rh.vpn.thelounge.net [10.10.10.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: h.reindl@thelounge.net)
        by mail.thelounge.net (THELOUNGE MTA) with ESMTPSA id 49fQP35knczXSW
        for <linux-ext4@vger.kernel.org>; Sat,  6 Jun 2020 18:45:22 +0200 (CEST)
To:     linux-ext4@vger.kernel.org
From:   Reindl Harald <h.reindl@thelounge.net>
Subject: ext4 filesystem being mounted at /boot supports timestamps until 2038
Organization: the lounge interactive design
Message-ID: <b944159f-01cb-9e48-309b-fe13e25e2340@thelounge.net>
Date:   Sat, 6 Jun 2020 18:45:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

are you guys kidding me?

* create a new vmware vdisk with 512 MB
* kernel 5.7.0, e2fsprogs-1.45.5-1.fc31.x86_64
* mount the filesystem

Jun  6 18:37:57 master kernel: ext4 filesystem being mounted at /boot
supports timestamps until 2038 (0x7fffffff)

https://lore.kernel.org/patchwork/patch/1172334/

-----------------------------

this does *not* happen when the vdisk is 768 MB instead just 512 MB
large - what's te point of defaults which lead to warnings like this in
2020?
