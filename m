Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2C6747545
	for <lists+linux-ext4@lfdr.de>; Sun, 16 Jun 2019 16:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbfFPOoq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 16 Jun 2019 10:44:46 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40157 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbfFPOop (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 16 Jun 2019 10:44:45 -0400
Received: by mail-pf1-f194.google.com with SMTP id p184so4221566pfp.7;
        Sun, 16 Jun 2019 07:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xOfBr7JlTH8fkki7imo8wyZIoxB0rfRm5CNLFhWSL4A=;
        b=eFYrWKiYTgoK0+0dLdC93eQqbojj5RLZB3X71Dk+0SJKgps+XrkwzlSUSb587/1kDf
         hlYhiXbRKOzvjm0rFUFJXICxZkhFcHR0thEOyKgB9iKwQ8/96aoL/1UFaMIjL5lwzxdp
         AF0M16ItSFMCpEehvOd2mV11D8ExZ5JqB2q3tMTUWctdhzypIiL3bGXvavFQHouUQ5Rv
         F3a1W74YsxJ9K/5KQK8rjKL7bngT0oKaZOL6+Hl4uWJ2MNt0Yrrp3GCZEJ2jeUkGy5cp
         l6CAPxKHOzt4dGqcl8Ih407diDxBjuihLrV2iyql05esS+PBHfZn7RSrW3RLCCRHtaOD
         i3AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xOfBr7JlTH8fkki7imo8wyZIoxB0rfRm5CNLFhWSL4A=;
        b=NyyPOhOl0JD1h840nsK/8pZwJN3Izw0QE7HaoMPiRRvzaXhTmDHq4dY2XnwGMPhyvG
         YZyzjaLs1zZvmQDUeaP2iLErSyQHgo7Oi+YqAjNKOD2baswsF/Lh1d1/ij4r9mAHAdBV
         wZkHbnkpE40idYo/dg+eaYzGRciCY7JFlHfOWZbP5MSknkgkfBZgGsNpccJ3+mtH6B2l
         uU4NO3PERfMl4nZ3HldvTLbqrl4HAYZGSoz0R/3aQkYLu3OZUSuY+7gz/d5UX9u5iU8p
         05aSIwiSrvsr3E+wrfgGc7b63OcF/k3/bCIXQrcW84Hh83b8pdVh3NXiUlAL4cQ1YQRs
         4khw==
X-Gm-Message-State: APjAAAUY3hKk1bxceOEYirq8npc39+s4t4CMsUWBIjgdBlHk03pCye6K
        XFT66gnzgTFZy4+irgdoIRQ=
X-Google-Smtp-Source: APXvYqw9Zr6DG/QcykUYxry3nmZ7Yv88xSbwGYxsegWEtbVZBNs+xov5Iu9o9EvXMVFKtVibkJaIyQ==
X-Received: by 2002:a17:90a:19d:: with SMTP id 29mr22006213pjc.71.1560696285178;
        Sun, 16 Jun 2019 07:44:45 -0700 (PDT)
Received: from localhost ([47.254.35.144])
        by smtp.gmail.com with ESMTPSA id q129sm3861806pfb.89.2019.06.16.07.44.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 16 Jun 2019 07:44:44 -0700 (PDT)
Date:   Sun, 16 Jun 2019 22:44:40 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     tytso@mit.edu, fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
        "Lakshmipathi.G" <lakshmipathi.ganapathi@collabora.co.uk>
Subject: Re: [PATCH v3 2/2] shared/012: Add tests for filename casefolding
 feature
Message-ID: <20190616144440.GD15846@desktop>
References: <20190612184033.21845-1-krisman@collabora.com>
 <20190612184033.21845-2-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612184033.21845-2-krisman@collabora.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jun 12, 2019 at 02:40:33PM -0400, Gabriel Krisman Bertazi wrote:
> From: "Lakshmipathi.G" <lakshmipathi.ganapathi@collabora.co.uk>
> 
> This new test implements verification for the per-directory
> case-insensitive feature, as supported by the reference implementation
> in Ext4.
> 
> Signed-off-by: Lakshmipathi.G <lakshmipathi.ganapathi@collabora.co.uk>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
>   [Rewrite to support feature design]
>   [Refactor to simplify implementation]

Test looks good to me, and test passes for me with v5.2-rc4 kernel and
latest e2fsprogs, thanks! Just that, I moved the test to generic, as we
have all the needed _require rules ready to _notrun on unsupported fs,
so it's ready to be generic. (Sorry I was not involved with the
ext4-shared-generic discussion in the first place)

Thanks,
Eryu
