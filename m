Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E93F9305F12
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Jan 2021 16:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235525AbhA0PFh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 27 Jan 2021 10:05:37 -0500
Received: from mail.ivde.bg ([84.1.246.67]:38822 "EHLO mail.ivde.bg"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235282AbhA0PB6 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 27 Jan 2021 10:01:58 -0500
X-Greylist: delayed 479 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Jan 2021 10:01:58 EST
Received: from localhost (localhost [127.0.0.1])
        by mail.ivde.bg (Postfix) with ESMTP id 13945C12BC
        for <linux-ext4@vger.kernel.org>; Wed, 27 Jan 2021 16:53:16 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ivde.bg; h=
        content-language:content-transfer-encoding:content-type
        :content-type:mime-version:user-agent:date:date:message-id
        :subject:subject:from:from:received:received; s=mail; t=
        1611759191; bh=gN2lTUs0IopON52cSWFg39wdFljWSxTd/ILRlIHCIfQ=; b=v
        xbW3DQ0XS+6mxYtcxAsBQbFRYjxl8eH8iFV03V4UMoshtqqLqlHr8bO1RBeroOrB
        TNE8V9e52ZKZfn8pdiyTbL2hmRSPJkZUtRkF5zS26g7AS2tDw3XF8SBRpf8u2K2N
        x2SE0m2UICsbb9C7ombbbCiETeesparuA3WgzqFbzc=
X-Virus-Scanned: Debian amavisd-new at mail.ivde.bg
Received: from mail.ivde.bg ([127.0.0.1])
        by localhost (mail.ivde.bg [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP for <linux-ext4@vger.kernel.org>;
        Wed, 27 Jan 2021 16:53:11 +0200 (EET)
Received: from [192.168.31.10] (vent.haskovo.ddns.bulsat.com [178.169.208.230])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ivde.bg (Postfix) with ESMTPSA id BC919C12B9
        for <linux-ext4@vger.kernel.org>; Wed, 27 Jan 2021 16:53:11 +0200 (EET)
To:     linux-ext4@vger.kernel.org
From:   "Ivaylo M. Ivanov" <i.ivanov@ivde.bg>
Subject: Please, do not remove mount options "nouser_xattr" and "noacl".
Message-ID: <774a00eb-ed3a-584e-2f1b-2c7d0075586c@ivde.bg>
Date:   Wed, 27 Jan 2021 16:53:09 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

Please, do not remove mount options "nouser_xattr" and "noacl".

I am using those to suppress xattr and acl in samba share to can scan 
files with clamav

Regards,
Ivaylo Ivanov

