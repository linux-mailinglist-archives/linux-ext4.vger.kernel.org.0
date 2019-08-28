Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB0AEA0041
	for <lists+linux-ext4@lfdr.de>; Wed, 28 Aug 2019 12:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbfH1Kxf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 28 Aug 2019 06:53:35 -0400
Received: from mail-pg1-f181.google.com ([209.85.215.181]:40040 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbfH1Kxf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 28 Aug 2019 06:53:35 -0400
Received: by mail-pg1-f181.google.com with SMTP id w10so1262023pgj.7
        for <linux-ext4@vger.kernel.org>; Wed, 28 Aug 2019 03:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SC0xEoyPKVJmcOv6IMxoiX1CRMvhxc/O/ny7sWMsncs=;
        b=jmEaHohmaCnCG5IJ0134iqz9Nc9jHPbc0g2LB9FbAfdEy0/k3N1pntOQBOBgiBR/YS
         Ius6kCq4Yy64CuYj5Mc7wOcpQkOA0vrkg2X2Mkq5jvdUx/ZRSzlM5UlVLwmgQxnyvMkD
         5RLJwsM22u/RAF1rhevfTlqmtbLDYoflTvavp6c9qvq6M3PwrDZDC6iK47t24E+AUmYN
         IRzLlaL4ZXltpesEZ6msOJJ2ipPkv+sNofMsvMvCMFGSXtNoSVp2ahB7TUUmzawumKV0
         JmhyaVB5S/zm2KSx0HGuHTXKtqg211gLouKgKCkCzXME5REe7EFZBZ6Cv6iJv7tRdKlp
         Txgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SC0xEoyPKVJmcOv6IMxoiX1CRMvhxc/O/ny7sWMsncs=;
        b=M9wiAnV15veOdvGcqFOdAGS9cbA1HwJ6dVN/ENHsMrWgFL6To+ZCrPrIXOcYDdmzOF
         qjmZ03SOR/OmJ0ZcJv1MgeUKGy394BPswU9iZp2c4dprv0TiYfoddeFsByOTfqqo0iKQ
         n4Zj7dU+wzVnzbEI21fd5yy8CGvWtqKiqFOH6vRe1JoSRQExta8SnVvQqy+n/Mo1bw6B
         xanlvJwsrAhV67+n7P4nrV1bh6THYlm/s/pLkxjBHh1BDkR4lL5mb5gU3gma+6idbsWd
         oaILnVAGy9BzeRycn5BFuG9gmIsFMSg9MXyQfh3ZWdJ5W+Eu+3owp35FJIrLbF1iqCVc
         EGsg==
X-Gm-Message-State: APjAAAUPw8FUAOapIpmxyaMYEcrEoi/WBORJAKkJgDTv+6P23hnDILsf
        8qgjFenFniyex65ulOkK3V7wowb2srOi
X-Google-Smtp-Source: APXvYqxZ0+AQzaXuYInpPHUJKLpAgDrj9yM/ypdzL6uS/i7KlmuHO9X0N2n9aY1/wZGXkJihfDg/OQ==
X-Received: by 2002:a65:514c:: with SMTP id g12mr2933712pgq.76.1566989613768;
        Wed, 28 Aug 2019 03:53:33 -0700 (PDT)
Received: from poseidon.bobrowski.net ([114.78.226.167])
        by smtp.gmail.com with ESMTPSA id s7sm4162049pfb.138.2019.08.28.03.53.32
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 03:53:33 -0700 (PDT)
Date:   Wed, 28 Aug 2019 20:53:28 +1000
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     linux-ext4@vger.kernel.org
Subject: Re: subscribe
Message-ID: <20190828105327.GB22165@poseidon.bobrowski.net>
References: <CAC0goKfHSVCtYM9nCsST1d=mXDFuwjm2xnymqZcCWZU7h3uR+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAC0goKfHSVCtYM9nCsST1d=mXDFuwjm2xnymqZcCWZU7h3uR+A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Aug 28, 2019 at 08:44:02PM +1000, Matthew Bobrowski wrote:
> subscribe

Heh, well, this is kinda embarrassing... This was meant to go to the
mailing list manager. :-)

And yes, it was a long day at work!
