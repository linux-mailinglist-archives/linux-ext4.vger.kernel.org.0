Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE991A6D00
	for <lists+linux-ext4@lfdr.de>; Mon, 13 Apr 2020 22:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733218AbgDMUMR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 13 Apr 2020 16:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727816AbgDMUMR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 13 Apr 2020 16:12:17 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51859C0A3BDC
        for <linux-ext4@vger.kernel.org>; Mon, 13 Apr 2020 13:12:16 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id g74so10806889qke.13
        for <linux-ext4@vger.kernel.org>; Mon, 13 Apr 2020 13:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=7wbIkNW4uK7jXs/v6i+IV7NRET5/HHqNf3siqgnGleQ=;
        b=HqEitrh1La9sLK2glZ8PodOXHoH/1m4ddXzA5vtyAP0dSPWyvfOVgFGm73aFRh1m9h
         9S0VaJn3w7HdHg1Hh4w07sd9T1SDp4ZHGVGseoIlFDLRMneJtdYfaD2yUoj7NiplhadA
         ME/VaL/UWefeG6+QzGxNw8hK3NqRaXRn1KTDN/NV/b7zTXYlh9UpfxAxn1avjcLFceI7
         /JnVWa01ixTvGnJHXTAx4Ay4vCNa08zxeBdNZuCkJFQFIAnHAxnsnyn7HbcesHX/9iVM
         oOx7qzFf5aIdbszDtn13o4+FToS8h3S4s+Oh87sfU5gQr9GYMDSKcIPijLk5yfnCgzj6
         dDBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=7wbIkNW4uK7jXs/v6i+IV7NRET5/HHqNf3siqgnGleQ=;
        b=os4hCjjG+9xUWsbDl7lE/d+AYuAPnv085Ic/WbJtIYW+e9vTXWbN0pSwITRcTmeXuS
         WNErDlupu0Qcuooz/RPbED0N5lMIWBlSuoIq1EDSdLLigYRtTnfKNwQQCzQx703BEzz/
         O5fzfNVGCqzKt8W64XtIzAo+2ey+4OvJRbuhgQBHTm8Oe1AFU1WmR+RI1D3NZbel/uYt
         N6323DdjKopM/f/c2IfuynzyjLKgiFaHVaF1DxBhpKHIAnpwW2qVPs03C2oUz3SPhA4G
         TMjVJRFIK/fx3yf4BQICa4+zCk5V0HDM0p5wjSA1NMt0+kk7gHbyfWfapYF8A1XOBDOB
         XVaA==
X-Gm-Message-State: AGi0PuZwuqh61SF8pf9S7BeSBU6RWuR8jJWnVPfBVcR3ulX1xPTdTCWy
        HWREvJZHRmPCLPFFQdGF1Px521vD
X-Google-Smtp-Source: APiQypJE4p0u5TfhsUIbjab1NORQjGL14utwcsJvSU0ztuMCaWcI+Ps4IdIzK5lUeYepUNa7NUsynw==
X-Received: by 2002:a37:9a54:: with SMTP id c81mr18244283qke.185.1586808734318;
        Mon, 13 Apr 2020 13:12:14 -0700 (PDT)
Received: from localhost.localdomain (c-73-60-226-25.hsd1.nh.comcast.net. [73.60.226.25])
        by smtp.gmail.com with ESMTPSA id i4sm9131025qkh.27.2020.04.13.13.12.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Apr 2020 13:12:13 -0700 (PDT)
Date:   Mon, 13 Apr 2020 16:12:11 -0400
From:   Eric Whitney <enwlinux@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     riteshh@linux.ibm.com
Subject: generic/456 regression on 5.7-rc1, 1k test case
Message-ID: <20200413201211.wbcotcr6rg523wzs@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

I'm seeing consistent failures for generic/456 while running kvm-xfstests' 1k
test case on 5.7-rc1.  This is with an x86-64 test appliance root file system
image dated 23 March 2020.

The test fails when e2fsck reports "inconsistent fs: inode 12, i_size is
147456, should be 163840".

Bisecting 5.7-rc1 identified the following patch as the cause:
ext4: don't set dioread_nolock by default for blocksize < pagesize
(626b035b816b).  Reverting the patch in 5.7-rc1 reliably eliminates the test
failure.

Eric
