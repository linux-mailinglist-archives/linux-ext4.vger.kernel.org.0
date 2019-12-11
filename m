Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2874411A646
	for <lists+linux-ext4@lfdr.de>; Wed, 11 Dec 2019 09:51:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbfLKIvy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 11 Dec 2019 03:51:54 -0500
Received: from relay.sw.ru ([185.231.240.75]:37430 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726845AbfLKIvy (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 11 Dec 2019 03:51:54 -0500
Received: from dhcp-172-16-24-104.sw.ru ([172.16.24.104])
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1iexhs-000496-Vm; Wed, 11 Dec 2019 11:50:53 +0300
Subject: Re: [PATCH RFC 0/3] block,ext4: Introduce REQ_OP_ASSIGN_RANGE to
 reflect extents allocation in block device internals
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Cc:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "tytso@mit.edu" <tytso@mit.edu>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "osandov@fb.com" <osandov@fb.com>,
        "jthumshirn@suse.de" <jthumshirn@suse.de>,
        "minwoo.im.dev@gmail.com" <minwoo.im.dev@gmail.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "andrea.parri@amarulasolutions.com" 
        <andrea.parri@amarulasolutions.com>,
        "hare@suse.com" <hare@suse.com>, "tj@kernel.org" <tj@kernel.org>,
        Ajay Joshi <Ajay.Joshi@wdc.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "asml.silence@gmail.com" <asml.silence@gmail.com>
References: <157599668662.12112.10184894900037871860.stgit@localhost.localdomain>
 <BYAPR04MB574961FE921EB3FEA03CAF77865A0@BYAPR04MB5749.namprd04.prod.outlook.com>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <a96e7af6-a807-1ca9-af50-4e0a7d771ac8@virtuozzo.com>
Date:   Wed, 11 Dec 2019 11:50:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB574961FE921EB3FEA03CAF77865A0@BYAPR04MB5749.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 11.12.2019 10:42, Chaitanya Kulkarni wrote:
>> Here is a simple test I did:
>> https://gist.github.com/tkhai/5b788651cdb74c1dbff3500745878856
>>
> 
> Somehow I'm not able to open this link, can you please share results
> in plain text on the email ?

#define _GNU_SOURCE
#include <sys/types.h>
#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <fcntl.h>
#include <errno.h>

#define BLOCK_SIZE 4096
#define STEP (BLOCK_SIZE * 16)
#define SIZE (4ULL * 1024 * 1024 * 1024)

int main(int argc)
{
	int fd, step, ret = 0;
	unsigned long i;
	void *buf;

	if (posix_memalign(&buf, BLOCK_SIZE, SIZE)) {
		perror("alloc");
		exit(1);
	}

	fd = open("file2.img", O_RDWR|O_CREAT|O_DIRECT);
	if (fd < 0) {
		perror("open");
		exit(1);
	}

	if (ftruncate(fd, SIZE)) {
		perror("ftruncate");
		exit(1);
	}

	ret = fallocate(fd, 0, 0, SIZE);
	if (ret) {
		perror("fallocate");
		exit(1);
	}
	
	for (step = STEP - BLOCK_SIZE; step >= 0; step -= BLOCK_SIZE) {
		printf("step=%u\n", step);
		for (i = step; i < SIZE; i += STEP) {
			errno = 0;
			if (pwrite(fd, buf, BLOCK_SIZE, i) != BLOCK_SIZE) {
				perror("pwrite");
				exit(1);
			}
		}

		if (fsync(fd)) {
			perror("fsync");
			exit(1);
		}
	}

	return 0;
}


