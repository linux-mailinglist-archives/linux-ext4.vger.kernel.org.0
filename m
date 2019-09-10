Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43DB9AE2D8
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Sep 2019 06:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732418AbfIJEVU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 10 Sep 2019 00:21:20 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40800 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729390AbfIJEVU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 10 Sep 2019 00:21:20 -0400
Received: by mail-wr1-f66.google.com with SMTP id w13so17148527wru.7;
        Mon, 09 Sep 2019 21:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=2DrkhGPdPNpHkFc5j7Jf+UBRr/PJrOsC0aoouCBeVg8=;
        b=iKwXphZFnd4EJ10aRhCsjbebrYziVjmDnBhFhxggI2H7MYiveCNHM0OzBNuR8z28cH
         rytuKJ+sQje6UxpLjumiEVlOl1fSg3d7xVtZ4Uutgrwt/LjrC4P2hZX2GzLcWgHV/law
         SlK/MjDV/ilT4sw90PUy2RrtIHGc4UPnGHAkjKkFCFR5PLKSPVypr3IKxICgbDCu6L6S
         GwPI6GRLWnm7CTnAd4Bhp3UxoQfU8uAtmpj+WtUBY4q9XheD1IQ0n1msxe4G50dguDgt
         ilRWQ7GCU+ACpuFExNgPGteJuWJImDEyn/Omg3/ym1vLjr7i9ZhmeR3eMnIXOAqgQGBH
         qvZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2DrkhGPdPNpHkFc5j7Jf+UBRr/PJrOsC0aoouCBeVg8=;
        b=AA9VWvufReMOZJw/inNkEjnP/yjLhSaOnHKszET0aNpA4llr8aY9MuH9PHSwU4MlJ7
         AxZXli211zMF/JfjbPaKENtrwJ4kd3FRe5NLybo539OLWtTvEEbRmXP6al/8uY6LeHEd
         hABwfPrIthDUhKI2tT/IevadQmdlW7gSESW0Gpjj6rXPQhdMIU8c6cGWe9MgW98/duaJ
         7p5I96LQowxoRhKPqeG/YQnzbLlzU5rDQlrBMaWxH1N5oWl604ho7fu8eyzy5tOeX53a
         5JKzTVW0vIKs21NF6lopXNiO1tkk+TgAu9WycFFg1Z8iiY+UjgMN4ep1RQZ7EpsXTTMx
         VMPg==
X-Gm-Message-State: APjAAAUHJr1KFvRnQ6Ojgk3VSieQLqxRlRMQQaLfCfVo1ltTC7ZsxFg7
        4wmg+oodVSXRJrm5SsLEsWJ/ikCI
X-Google-Smtp-Source: APXvYqxJIc7uwWOmEG3nKFmsUhigEYGQLBX5eTHq0QbT1GRyaQPib9ERqFSJiaTPJnqpzYoZfM8ZMQ==
X-Received: by 2002:adf:ef05:: with SMTP id e5mr22668169wro.127.1568089278090;
        Mon, 09 Sep 2019 21:21:18 -0700 (PDT)
Received: from darwi-home-pc (ip-109-42-2-46.web.vodafone.de. [109.42.2.46])
        by smtp.gmail.com with ESMTPSA id x5sm23142789wrg.69.2019.09.09.21.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 21:21:17 -0700 (PDT)
Date:   Tue, 10 Sep 2019 06:21:07 +0200
From:   "Ahmed S. Darwish" <darwish.07@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jan Kara <jack@suse.cz>, zhangjs <zachary@baishancloud.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Linux 5.3-rc8
Message-ID: <20190910042107.GA1517@darwi-home-pc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whBQ+6c-h+htiv6pp8ndtv97+45AH9WvdZougDRM6M4VQ@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi,

On Sun, Sep 08, 2019 at 01:59:27PM -0700, Linus Torvalds wrote:
> So we probably didn't strictly need an rc8 this release, but with LPC
> and the KS conference travel this upcoming week it just makes
> everything easier.
>

The commit b03755ad6f33 (ext4: make __ext4_get_inode_loc plug), [1]
which was merged in v5.3-rc1, *always* leads to a blocked boot on my
system due to low entropy.

The hardware is not a VM: it's a Thinkpad E480 (i5-8250U CPU), with
a standard Arch user-space.

It was discovered through bisecting the problem v5.2 => v5.3-rc1,
since v5.2 never had any similar issues. The issue still persists in
v5.3-rc8: reverting that commit always fixes the problem.

It seems that batching the directory lookup I/O requests (which are
possibly a lot during boot) is minimizing sources of disk-activity-
induced entropy? [2] [3]

Can this even be considered a user-space breakage? I'm honestly not
sure. On my modern RDRAND-capable x86, just running rng-tools rngd(8)
early-on fixes the problem. I'm not sure about the status of older
CPUs though.

Thanks,

[1]
  commit b03755ad6f33b7b8cd7312a3596a2dbf496de6e7
  Author: zhangjs <zachary@baishancloud.com>
  Date:   Wed Jun 19 23:41:29 2019 -0400

      ext4: make __ext4_get_inode_loc plug

      Add a blk_plug to prevent the inode table readahead from being
      submitted as small I/O requests.

      Signed-off-by: zhangjs <zachary@baishancloud.com>
      Signed-off-by: Theodore Ts'o <tytso@mit.edu>
      Reviewed-by: Jan Kara <jack@suse.cz>

[2] https://lkml.kernel.org/r/20190619122457.GF27954@quack2.suse.cz

[3] block/blk-core.c :: blk_start_plug()

--
darwi
http://darwish.chasingpointers.com
