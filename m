Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8588041A0DD
	for <lists+linux-ext4@lfdr.de>; Mon, 27 Sep 2021 22:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237066AbhI0U7G (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 27 Sep 2021 16:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236843AbhI0U7G (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 27 Sep 2021 16:59:06 -0400
X-Greylist: delayed 442 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 27 Sep 2021 13:57:27 PDT
Received: from mx02.fc.ul.pt (mx02.fc.ul.pt [IPv6:2001:690:21c0:f602::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE32C061604
        for <linux-ext4@vger.kernel.org>; Mon, 27 Sep 2021 13:57:26 -0700 (PDT)
Received: from FC-MBX12.fc.ul.pt (FC-MBX12.fc.ul.pt [10.121.30.27])
        by mx02.fc.ul.pt (8.14.4/8.14.4) with ESMTP id 18RKnT6P059445
        for <linux-ext4@vger.kernel.org>; Mon, 27 Sep 2021 21:49:29 +0100
Received: from FC-MBX13.fc.ul.pt (10.121.30.28) by FC-MBX12.fc.ul.pt
 (10.121.30.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7; Mon, 27 Sep 2021
 21:49:29 +0100
Received: from FC-MBX12.fc.ul.pt (10.121.30.27) by FC-MBX13.fc.ul.pt
 (10.121.30.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7; Mon, 27 Sep 2021
 21:49:29 +0100
Received: from smtp.ciencias.ulisboa.pt (194.117.42.59) by FC-MBX12.fc.ul.pt
 (10.121.30.27) with Microsoft SMTP Server id 15.2.922.7 via Frontend
 Transport; Mon, 27 Sep 2021 21:49:29 +0100
Received: from [IPv6:2001:8a0:6cc5:7e01:e4fa:f5ca:7303:4e82] (unknown [IPv6:2001:8a0:6cc5:7e01:e4fa:f5ca:7303:4e82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: fc26887)
        by smtp.ciencias.ulisboa.pt (Postfix) with ESMTPSA id 2998640A0BDD
        for <linux-ext4@vger.kernel.org>; Mon, 27 Sep 2021 21:49:29 +0100 (WEST)
To:     <linux-ext4@vger.kernel.org>
From:   Andre Coelho <fc26887@alunos.fc.ul.pt>
Subject: fs ideas
Message-ID: <5a0b3e05-d513-0d53-ee34-5d78f823f059@alunos.fc.ul.pt>
Date:   Mon, 27 Sep 2021 21:49:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-FCUL-MailScanner-Information: Please contact the ISP for more information
X-FCUL-MailScanner-ID: 18RKnT6P059445
X-FCUL-MailScanner: Found to be clean
X-FCUL-MailScanner-From: fc26887@alunos.fc.ul.pt
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hey, got some fs ideas , hope it helps. :) (if not ignore this :)). I 
just did in this in the remote change that this is helpful

https://drive.google.com/drive/folders/1QA0N93fLAFLf__9-cRNew8AgTUscQ0pl

-- 
André Albergaria Coelho
fc26887@alunos.fc.ul.pt

