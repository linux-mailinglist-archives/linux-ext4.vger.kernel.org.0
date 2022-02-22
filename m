Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 651534BF75B
	for <lists+linux-ext4@lfdr.de>; Tue, 22 Feb 2022 12:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231752AbiBVLkv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 22 Feb 2022 06:40:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231747AbiBVLku (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 22 Feb 2022 06:40:50 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54505136EE7;
        Tue, 22 Feb 2022 03:40:25 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id j17so5923851wrc.0;
        Tue, 22 Feb 2022 03:40:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:mime-version:content-transfer-encoding
         :content-description:subject:to:date:reply-to;
        bh=zncUP4k0qWTkrruw/2Qwtl328+sz3ixjRaMsIKFNcuk=;
        b=XuEBGqk1UWckbKz/Q0ppMwA+n/lm00aE9YMAHsMtfR7s0qipKYab2gYfuvhTKNXdpO
         kLc+PGiANsE1AsQnGNo+gfxziyYfr+scVn5OwHqARXbOnHLxfRXu3rjaQHRBuvNaaX4J
         ve02x7eReY4nM/xmPsra7xA6zvTKJaNhj12kZE1mXogJmU2HL4ykbR6nY3g3NmrIzPXA
         c02H+C/gNdjDnBfTh0F+8VkYqYe0oBTl88h+5oO6eaK0tObgUm+KfsDAriC9LBxb+Xc+
         9K5gtzWS6vkqSRkCys2FsxLrMAQ9l25sWvmg51i4jACyMdvRUwwaVGBBa2ETwwRWa7i+
         PgPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:mime-version
         :content-transfer-encoding:content-description:subject:to:date
         :reply-to;
        bh=zncUP4k0qWTkrruw/2Qwtl328+sz3ixjRaMsIKFNcuk=;
        b=S8mGMwyhpPvpERgnvW7uaa9mReLNbD3ojdRMNOU0ST4ALyGqt5scm4NUPwqV8dLo5Q
         c5hpuVTuUzsJVRyAHsU5OKwGm9xNBmXXksP2ZpZx8rRWkLDBK7R/+m7L9AXCZfRwP3eA
         I2cxDq/AsyctLNMlSaE72LUTJHtwPqDEjB5UcOFO3HwahJvmgLX+88Yek04yeNFZCeeI
         Dso2XTqKF1sV7TJD9U5Ll/SfQXVIVkDpPjgP3miGrXPnkuXb7v2Q9fTMbs4Z+B0xK0k0
         1qFOQ0GEChpLomrfrrWpKgCHNrgZbwNSEAZB4c4CAehi7n5H2PPOSn/16WcHyfUmweGQ
         rPpQ==
X-Gm-Message-State: AOAM53360zTL+h9NnvwhXmJ5lOpSLqLr/j1y+tuwPCY6V5lKpQD9Md+H
        M33fzqxljYB+dCR9oNk9rX0=
X-Google-Smtp-Source: ABdhPJz1IaIbefl8JOdUJUpr36UXp0n5OEscVfyeW0XlUGPsfMJATfvgRM0LgNi+Y04N5AYQZVvfaA==
X-Received: by 2002:a05:6000:188b:b0:1e3:1cfa:5851 with SMTP id a11-20020a056000188b00b001e31cfa5851mr20035629wri.510.1645530023937;
        Tue, 22 Feb 2022 03:40:23 -0800 (PST)
Received: from MACBOOKPROF612.localdomain ([102.165.192.234])
        by smtp.gmail.com with ESMTPSA id c17sm2093025wmh.31.2022.02.22.03.40.17
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 22 Feb 2022 03:40:23 -0800 (PST)
Message-ID: <6214cba7.1c69fb81.bb0b.71a2@mx.google.com>
From:   Scott Godfrey <markmillercom322@gmail.com>
X-Google-Original-From: Scott Godfrey
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: CONGRATULATION!!!!
To:     Recipients <Scott@vger.kernel.org>
Date:   Tue, 22 Feb 2022 13:40:14 +0200
Reply-To: scottgodfrey.net@gmail.com
X-Antivirus: AVG (VPS 220222-0, 2/22/2022), Outbound message
X-Antivirus-Status: Clean
X-Spam-Status: No, score=4.6 required=5.0 tests=ADVANCE_FEE_2_NEW_MONEY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        LOTS_OF_MONEY,MONEY_FRAUD_3,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,TO_MALFORMED,T_SCC_BODY_TEXT_LINE,
        XFER_LOTSA_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

My Name is Scott Godfrey. I wish to inform you that The sum of $2,500,000(M=
illion)has been donated to you.I
won a fortune of $699.8 Million in the Million Dollars Power-Ball Jackpot L=
ottery,2021.And I am
donating part of it to five lucky people and five Charity
organization. Your email came out victorious. Please contact via email: sco=
ttgodfrey.net@gmail.com. For more information about your claims. Thanks.


-- 
This email has been checked for viruses by AVG.
https://www.avg.com

