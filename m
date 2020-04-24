Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A74001B73AE
	for <lists+linux-ext4@lfdr.de>; Fri, 24 Apr 2020 14:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbgDXMPe (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 24 Apr 2020 08:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbgDXMPd (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 24 Apr 2020 08:15:33 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2ADBC09B045
        for <linux-ext4@vger.kernel.org>; Fri, 24 Apr 2020 05:15:32 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id r7so6994358edo.11
        for <linux-ext4@vger.kernel.org>; Fri, 24 Apr 2020 05:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=VaLtaaXl5Np/N62czV+bs3R+wVdR7dbsmP4ZYr6CuAo=;
        b=CoV4jb9fOdEPE3QhxGK4aGcTiZvEFjJVVZNxIAhG0os8yooe+aKHXR6pAbdp8VEbYc
         G6/MSeLZk3pr8vjdiW8zioJlaGjIAvOs9VX/nDbqKtpeXnYMjUnn7bd4VpR8k/Wv4WBu
         eRY6+TPUmCf+8478SVwfM3Z48/65WAaKcvzubeh12QDV5GEdZNfj76Y4Z6LrII779ANM
         niCHTC0eyJp1YlGj9Ths0voTZ1WmCrmVLtKijGOw9FA1dJjUqMtRT9PYSlIFF6EClhm+
         cCs4Ul4Y5mFfIysNw5d3zAF9O/GNenWjitX/+VdN4nllAoDmBGj667WFrDoD/M3Yr0NA
         /mOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=VaLtaaXl5Np/N62czV+bs3R+wVdR7dbsmP4ZYr6CuAo=;
        b=kS+9RZ2Pl/zCgDsebX/DsUSRsHOMfDAYlPgOWp1m1Cqf+QlXleQs51TN+dZrQTzUIm
         +bWmn0zgYP/sxG0ciEf/Z8mjuZ/wgE/alQ7WhrfL2QFILj5JcyNtmGjOJYW3+9gGnNQJ
         oyp3nDMb4XDEMr3T1OXmxNMv9WTRugCmz+ZJQOwK/O/XZaI6qEBNjBYe6qRju9PSaQ6D
         AlI4agYuM34DtT8PKzW7vhqfdzLjh0eDd2x/rRhyrh1TIsT/83TDGOB1JDbYent3LuOQ
         PIcjUV5XW6258ZbL/bUWaBoDhDcL7GmoN/ILT0TcNEKg2xA4p6UqfLINeG4wuuFvCrqT
         fbJg==
X-Gm-Message-State: AGi0PubJjgshtjCTNi11SmW10zEZeVN0cVN43WwQqrNKQup2TqlWAXjn
        3WR39qZnuu1gVXIC53vPXl9jDTHA5plQeho3H8RmSXuNVVJljQ==
X-Google-Smtp-Source: APiQypJjcT61g3Q8pQ5ZqiSf56DKLH75DC1QHHApuqW+rOP06HZ2GZgvIAm2dGKsP6KZrGeWlhpTeqPSr2ZM7QyRw/g=
X-Received: by 2002:a05:6402:75a:: with SMTP id p26mr6780104edy.311.1587730531288;
 Fri, 24 Apr 2020 05:15:31 -0700 (PDT)
MIME-Version: 1.0
From:   Mingye Wang <arthur200126@gmail.com>
Date:   Fri, 24 Apr 2020 20:15:21 +0800
Message-ID: <CAD66C+atWzdmdHDS00C_sARHzTwGGCAWPntf2doabsx_9jB2gw@mail.gmail.com>
Subject: Any updates on ext4-lazy (lazy_journal branch for SMR)?
To:     linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Ted,

With the whole unlabelled device-managed SMR fiasco happening earlier
this month, I stumbled upon your 2017 talk on ext4-lazy. Are there any
updates on the merge progress since [0]?

  [0]: https://lists.openwall.net/linux-ext4/2017/04/18/1

Regards,
Mingye Wang (Artoria2e5)
