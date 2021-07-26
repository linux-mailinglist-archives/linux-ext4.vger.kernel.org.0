Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EFA73D686E
	for <lists+linux-ext4@lfdr.de>; Mon, 26 Jul 2021 23:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232922AbhGZU1n (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 26 Jul 2021 16:27:43 -0400
Received: from mail.thelounge.net ([91.118.73.15]:21393 "EHLO
        mail.thelounge.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232772AbhGZU1m (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 26 Jul 2021 16:27:42 -0400
X-Greylist: delayed 1044 seconds by postgrey-1.27 at vger.kernel.org; Mon, 26 Jul 2021 16:27:42 EDT
Received: from srv-rhsoft.rhsoft.net (rh.vpn.thelounge.net [10.10.10.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: h.reindl@thelounge.net)
        by mail.thelounge.net (THELOUNGE MTA) with ESMTPSA id 4GYXBX40sbzXjN;
        Mon, 26 Jul 2021 22:50:39 +0200 (CEST)
Subject: Re: Is labelling a mounted ext2/3/4 file system safe and supported?
To:     Mike Fleetwood <mike.fleetwood@googlemail.com>,
        linux-ext4@vger.kernel.org
References: <CAMU1PDgNvW_3Jr91iii-Nh=DCuRytVG8ka3-J+a43gKwigx8Yg@mail.gmail.com>
From:   Reindl Harald <h.reindl@thelounge.net>
Organization: the lounge interactive design
Message-ID: <34ca4e40-2026-d48d-7181-fbea6ba4f140@thelounge.net>
Date:   Mon, 26 Jul 2021 22:50:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAMU1PDgNvW_3Jr91iii-Nh=DCuRytVG8ka3-J+a43gKwigx8Yg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



Am 26.07.21 um 20:45 schrieb Mike Fleetwood:
> Hi,
> 
> Using e2label to set a new label for a mounted ext4 seems to work, but
> is it a safe and supported thing to do?

it is


