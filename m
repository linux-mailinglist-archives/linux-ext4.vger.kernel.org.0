Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 571D83BE27E
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Jul 2021 07:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbhGGF2X (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 7 Jul 2021 01:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbhGGF2W (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 7 Jul 2021 01:28:22 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1D2C061574;
        Tue,  6 Jul 2021 22:25:42 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id a13so1487803wrf.10;
        Tue, 06 Jul 2021 22:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=L5lItkFFFNbxa+M7h/v//0YCk3dK3B/bMcyoFdTosZg=;
        b=eMuyz+L4LfR/TqFwkVAwGbOmn/2irdoyd3cN4darPc79ezid9oO4qa591XqTFz4gB4
         A9DxOAByFtNfCaDpuSSoqSQbLBDQpPefWVvzR5BC1OhApFXK51Js2gwhhFw4j5hX1kee
         OZBDU6UWh5OYwUm0mU3hqZe6Lk1zUVhgJNxrWbJLYwjf7ixg5vWd4m8DwpkMUP+JOcWe
         Uhj3NVAqWJs5NS2eWl4U/2F0yj3ysAeEaBGz6olkP7D0rsVeJzujPpFRQ7fJbx9CYunF
         LntTXbWUZkiK4PLYjzc3AMOirnPXza5Ve+4WQ4dLOcRzoMp6Aw/5d+1Pztfp4eumFa31
         Qrqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=L5lItkFFFNbxa+M7h/v//0YCk3dK3B/bMcyoFdTosZg=;
        b=QrnUwWwU+DgBHhJ7g3l8A4dpE7d1GZb7ZqmNx9mv//s7QXJ3Bpf3sfIqHXYhGk4d3S
         01ylb/G6beRpYVIYiZlK4WBCpM2bgEwotkIPHg8M5DcCLYCF/eAQdXFXRXCgZ4gPjJX/
         tOFKvtEsnnn9GBFrYiXX2gEF4ZMzluiQr5X9Egknbq15fexfSmhKGVAWoLGT+LU1np7X
         0kBpqnQWVGBqJT2N+xdzATgZcYK9l4mn8z14bFMNDrCQCLD8SzUrQBMOBEOt/mMOKEOE
         JLOPziIznSO6EF+SpqTvM0GTelMjOE0RXRQi+IlIv5d6ZFwWQNgAdOqBbOvVpNVE940u
         jxBQ==
X-Gm-Message-State: AOAM531YL8j3qeEtzI9FOzDGM1IqMfDbStPX1VrWqwIHkd5kCPqBnF5i
        FapTwMISzMUwHdNksQ6NjPuHlDzHXb8ePA==
X-Google-Smtp-Source: ABdhPJyQtoRVqy2pYz898UhDWz8GQMtrQzteAGL1b65SzGQPY1UdOOlx9nbf75oaASbUNytYRS8DuQ==
X-Received: by 2002:a5d:4590:: with SMTP id p16mr26351538wrq.253.1625635540760;
        Tue, 06 Jul 2021 22:25:40 -0700 (PDT)
Received: from [192.168.178.146] (p508df717.dip0.t-ipconnect.de. [80.141.247.23])
        by smtp.gmail.com with ESMTPSA id u2sm12406747wmc.42.2021.07.06.22.25.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jul 2021 22:25:40 -0700 (PDT)
Subject: Re: [PATCH] ext4: Fix comments and spaces to follow coding style
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     adilger.kernel@dilger.ca, trivial@kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210706183900.310975-1-j4n6ru@gmail.com>
 <YOSs9Qu1YpvPAP6v@mit.edu>
From:   Jan Gru <j4n6ru@gmail.com>
Message-ID: <38d5a68b-7871-b178-4d3b-358c062fcada@gmail.com>
Date:   Wed, 7 Jul 2021 07:25:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YOSs9Qu1YpvPAP6v@mit.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


On 06.07.21 21:20, Theodore Ts'o wrote:
> On Tue, Jul 06, 2021 at 08:39:00PM +0200, Jan Gruber wrote:
>> [...]
> Please don't send "checkpatch.pl --file" patches for the ext4 file
> system; if you must, please focus on files in the drivers directory,
> where they are more welcome.  If developers are making changes to a
> file, fixing some checkpatch.pl whines is fine, but white-sapace only
> changes just obfuscates "git blame" code archology, and so the costs
> far outwieghs the costs.  "Fix" is also not the right verb to use.
> For more information please see [1].
>
> [1] https://gist.github.com/17twenty/8154928
>
> If you are looking for subtantive ways of contributing to the ext4
> file system, feel free to look at various syzbot warnings[2] and try
> to figure out what is going on there.
>
> [2] https://syzkaller.appspot.com/upstream
>
> (In some cases, the syzbot complaint has already been fixed, and it's
> just a matter of letting syzbot knoww that it has since been fixed by
> a particular commit.  See [3] for more details.)
>
> [3] https://github.com/google/syzkaller/blob/master/docs/syzbot.md
>
> Cheers,
>
> 						- Ted

Thank you very much for the hints, Ted!

As a kernel newbie I was not aware, that it is undesirable to send
cleanup patches. I won't do that again.

I'm thankful for the provided resources, which look valuable to me.
In the future I will try to find and tackle syzbot-errors, as you
proposed.

Sorry for bothering you with a trivial cleanup-patch.

Best regards,
         Jan
