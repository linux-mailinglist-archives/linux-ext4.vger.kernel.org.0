Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B117168769
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Feb 2020 20:26:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729702AbgBUTZ4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 21 Feb 2020 14:25:56 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41913 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbgBUTZz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 21 Feb 2020 14:25:55 -0500
Received: by mail-lj1-f195.google.com with SMTP id h23so3346340ljc.8;
        Fri, 21 Feb 2020 11:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gXPd85Pnp91PUN/NJuXT0KXu2cxG6K0IeHqut9hrGwM=;
        b=WKamY8dnZFnwRBhdebMhr93A4BAGF+dTTtp2d1M5GNbMem8q8Wd9Oobh4XXs0UJhAd
         +i5go1JUHeP0Ik3xmTI/f4VciZKbGOyxn393K24KqwcJyBpkyKNkB5zFJy7Hx3lP9TLW
         Qa/G9TOw7aNyIHGRTrwy+AhPssgZXSs8Mq3R5DZSoGDSrWy/I73s83depna6zx3kAYiR
         ly82xUus7UN0uxqY6YHl9cB53p25OARqp2LX2ygPEhB1+/sKoYu6zmZHmzYsxLxTCBfG
         0VVgQOqHHhpfZGsAx/guwmErUlhpFy6x1l5bupC/Kfadto2W3tY8UkUbwsUAQslhx3yz
         jN+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gXPd85Pnp91PUN/NJuXT0KXu2cxG6K0IeHqut9hrGwM=;
        b=C8bqPMWrQyGzyTmXzBgS4VbsAc1gf+tQa3z4y07el77Owy7ZDaVPV7D+DemZGWf1MQ
         CFKkNHY+HNr2rlLsejk7Cr/qzS2sgU7yWrDNiz5wXx30zhWcnvq7H8Edg9beBSAXs/fe
         8snDxAlq/Evc/XKSKklVV4eezK9kQM/dG8c89BjM85iR7c3EjzCE//0Yy7AvpWXAd8N2
         4ckKsnVOHrMgH7786T+mHCjAJs5+V5b7gkVRLrvtbHV3vNqBhft507cdqf1W+ITznUY6
         1YBnVvRn1QUFH1yJG1gKmKvD3RnmXb00cyv2/5d7a+7ilLO0+0ZTfDr8ijzuFtmcZ+ML
         FuXw==
X-Gm-Message-State: APjAAAVTHdfaivTgYSjTi7c8H2yvKok7iRq786dIbZfQmocU42BOHP1E
        NivCV6xraPrImvut36GV1QQ=
X-Google-Smtp-Source: APXvYqyL6gIMh6FU728UcXfMrxrQ7Y4FgeZqIXdr2KDlh4wSfBaFl9BkcSINwlC872seDcPBHpi+WA==
X-Received: by 2002:a2e:84d0:: with SMTP id q16mr23309239ljh.138.1582313153651;
        Fri, 21 Feb 2020 11:25:53 -0800 (PST)
Received: from pc636 ([37.139.158.167])
        by smtp.gmail.com with ESMTPSA id d11sm2159880lfj.3.2020.02.21.11.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 11:25:53 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Fri, 21 Feb 2020 20:25:46 +0100
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Suraj Jitindar Singh <surajjs@amazon.com>,
        LKML <linux-kernel@vger.kernel.org>, rcu@vger.kernel.org
Subject: Re: [PATCH RFC] ext4: fix potential race between online resizing and
 write operations
Message-ID: <20200221192546.GA11003@pc636>
References: <20200215233817.GA670792@mit.edu>
 <20200216121246.GG2935@paulmck-ThinkPad-P72>
 <20200217160827.GA5685@pc636>
 <20200217193314.GA12604@mit.edu>
 <20200218170857.GA28774@pc636>
 <20200221120618.GA194360@google.com>
 <20200221132817.GB194360@google.com>
 <20200221192152.GA6306@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221192152.GA6306@pc636>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

> 
>   llist_for_each_safe(llnode, t, llist_del_all(&p->list))
>      vfree((void *)llnode, 1);
>
Should be kvfree((void *)llnode, 1);

--
Vlad Rezki
