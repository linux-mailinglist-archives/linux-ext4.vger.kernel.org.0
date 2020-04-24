Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E60111B7E6C
	for <lists+linux-ext4@lfdr.de>; Fri, 24 Apr 2020 20:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729183AbgDXS5F (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 24 Apr 2020 14:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728950AbgDXS5E (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 24 Apr 2020 14:57:04 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5197BC09B048
        for <linux-ext4@vger.kernel.org>; Fri, 24 Apr 2020 11:57:03 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id a9so5580579ybc.8
        for <linux-ext4@vger.kernel.org>; Fri, 24 Apr 2020 11:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=0zz42/ra9hOcefSa9UEsbViaWM9On0ERy9ZFSVmeTrA=;
        b=mpW2m7Dmh8+MLE7if1YJKmXIactKR6xM/EK1pwg2iUsGtbyv0ds1AYS+0wxzjdloG/
         kVlggshXv1Iw0ackYqqNT6SL4tHcj3EIlMgMctAljM4elYm7WRwky1rVbga53g1C+dhm
         qe0a1Rv+75WZLtYVHJL746mR7eac88OSRlX9QtjVJ0s/v5LcfkxnL+/p67qFRwEwkd08
         vLuTSInMINs5UvVrue5EKGIKPAl9gXXtTj/v59V/tbuQmdz3Zy9rwuxo3PoZ9XSTUbmg
         LUZ2XoFVY+JPVCvoA+yRYkhy7RYOWiVK5nXiSCeRxMBpZqYxRcU6bVmPTgf9L+vjoPa2
         Qacg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=0zz42/ra9hOcefSa9UEsbViaWM9On0ERy9ZFSVmeTrA=;
        b=Fp06XzLWBiYAukTr1qiExIVqD8hgdibaMW4IaQg5RxhftF9rPzIazVshjQSVZWNwTz
         7JrcGN6NmP7mPuYsZHAANgR+UXRrOpYW9+kVQGU+v/awIRfragm2JJ4D73efTbay6x4R
         vsAJWiT764/GlqVByQSvGu9K8hl7Dn4TqRPUDNzPmQIXNqib3WuwsR5frKIVkiGsI+rP
         fuS5FgmxOlroYXozQvD4n0SyjMh75hLeZ/MBIUaK5Q295nY4nmmRxf3cppuItysThoVi
         JuLBc5wZOiSy8C5PuJZIMY4FhaYReg5SozWgqJ+1gZlwzBQ/ncuu1D0ztcQbBg1ezePQ
         Zhbg==
X-Gm-Message-State: AGi0Puaus4aKFeg1wLLWCDn4KNclcNFPv0VCBtAg0ijoPBfBB9P0kz5U
        QoCLVtwKAbLS2ND3nMmXayREENtHKFEbaamIiwW0HqIQdM4=
X-Google-Smtp-Source: APiQypKDAqYvVWcS0EV3dmGi1YXdshxLyHtvPQPsYV2kxPOZVDPm6hgYX+LtwRvLMbbTt4ZPxPDoeIYYp2OLNjP1ZFk=
X-Received: by 2002:a25:ba81:: with SMTP id s1mr17149163ybg.508.1587754622000;
 Fri, 24 Apr 2020 11:57:02 -0700 (PDT)
MIME-Version: 1.0
From:   Alok Jain <jain.alok103@gmail.com>
Date:   Sat, 25 Apr 2020 00:26:49 +0530
Message-ID: <CAG-6nk-Q16UBbUkWoogut0fYP9s78x0OMf946Dg-tJk1nd+kzA@mail.gmail.com>
Subject: Need help to understand Ext4 message in /var/log/message file
To:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        Andreas Dilger <adilger@dilger.ca>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Guys,

I need an help to understand the following messages printed in
/var/log/message file

Apr 20 17:42:44 mylinux audispd: node=mylinux type=EXECVE
msg=audit(1587404564.745:5901346): argc=4 a0="mount" a1="-v"
a2="UUID=b1d54239-2b18-44b3-a4bf-5e0ca32b8f78" a3="/tmp/aj/m1"
Apr 20 17:42:45 mylinux kernel: [4633324.069180] EXT4-fs (sde1):
recovery complete
Apr 20 17:42:45 mylinux kernel: [4633324.070157] EXT4-fs (sde1):
mounted filesystem with ordered data mode. Opts: (null)


Actualy one of the iSCSI device is mounted to /tmp/aj/m1 with UUID
(U1) I unmounted this device and mounted new device (UUID
b1d54239-2b18-44b3-a4bf-5e0ca32b8f78) after mount I see the UUID of
newly mounted device changed to U1 and new device got corrupted. I ran
fsck to fix the device but UUID was changed to U1.

Any help is greatly appreciated.

Thanks,
Alok
